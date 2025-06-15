using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Course.DataServices;
using Course.Models;
using Microsoft.Maui.Controls;
using Microsoft.Maui.Dispatching;
using Plugin.Maui.Audio;
using System.Collections.ObjectModel;

namespace Course.ViewModels;

[QueryProperty(nameof(BookModel), "ViewBookDetails")]
public partial class BookDetailsPageViewmodel : ObservableObject
{
    private readonly IAudioManager _audioManager;
    private IAudioPlayer _player;
    private User _currentUser;

    [ObservableProperty] private Book _bookModel;
    [ObservableProperty] private TimeSpan _currentPosition;
    [ObservableProperty] private TimeSpan _duration;
    [ObservableProperty] private bool _isPlaying;
    [ObservableProperty] private double _playbackSpeed = 1.0;
    [ObservableProperty] private double _manualSliderValue;
    [ObservableProperty] private string _newReviewContent;
    [ObservableProperty]
    ObservableCollection<Review> _reviews;
    private bool _hasRecordedListen = false;
    [ObservableProperty] private string _bookListenStats;
    [ObservableProperty]
    private string _bookDetailsStatsText;
    [ObservableProperty]
    private bool hasListened;

    private readonly ReviewService _reviewService = new();
    private IDispatcherTimer _timer;

    public BookDetailsPageViewmodel(IAudioManager audioManager)
    {
        _audioManager = audioManager;
        _timer = Application.Current.Dispatcher.CreateTimer();
        _timer.Interval = TimeSpan.FromMilliseconds(500);
        _timer.Tick += (_, _) => UpdatePosition();

        Reviews = new ObservableCollection<Review>();
    }

    public User CurrentUser
    {
        get => _currentUser;
        set
        {
            SetProperty(ref _currentUser, value);
            _ = BookDetailsStats();
        }
    }


    partial void OnBookModelChanged(Book value)
    {
        LoadAudio(value.AudioFilePath);
        LoadReviews();
        _ = CheckIfUserListened(); 
    }
    private async void LoadReviews()
    {
        if (BookModel == null) return;
        var reviews = await _reviewService.GetReviewsForBookAsync(BookModel.Id);
        MainThread.BeginInvokeOnMainThread(() =>
        {
            Reviews = new ObservableCollection<Review>(reviews);
        });
    }

    [RelayCommand]
    public async Task AddReview()
    {
        Console.WriteLine("Кнопка добавления отзыва нажата");

        if (string.IsNullOrWhiteSpace(NewReviewContent) || BookModel == null || CurrentUser == null)
        {
            Console.WriteLine("Проверка не пройдена: пустой отзыв, отсутствует книга или пользователь");
            return;
        }

        int authorId = CurrentUser.Role == UserRole.Author ? CurrentUser.Id : 0;

        var review = new Review
        {
            BookId = BookModel.Id,
            AuthorId = authorId,
            Content = NewReviewContent,
            CreatedAt = DateTime.UtcNow
        };

        try
        {
            Console.WriteLine($"Попытка добавить отзыв: '{NewReviewContent}' для книги Id={BookModel.Id}, AuthorId={authorId}");

            await _reviewService.AddReviewAsync(review);  // Здесь просто await без присвоения

            Console.WriteLine("Отзыв успешно добавлен в сервис");

            NewReviewContent = string.Empty;

            if (Reviews == null)
            {
                Reviews = new ObservableCollection<Review>();
            }

            MainThread.BeginInvokeOnMainThread(() =>
            {
                Reviews.Insert(0, review);
            });
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Ошибка при добавлении отзыва: {ex.Message}");
        }
    }


    private void LoadAudio(string path)
    {
        if (!File.Exists(path))
        {
            Console.WriteLine("Файл не найден: " + path);
            return;
        }

        var fileStream = File.OpenRead(path);
        _player = _audioManager.CreatePlayer(fileStream);

        Duration = TimeSpan.FromSeconds(_player.Duration);
        ManualSliderValue = 0;
        CurrentPosition = TimeSpan.Zero;
    }


    [RelayCommand]
    private async void PlayPause()
    {
        if (_player == null) return;

        if (IsPlaying)
        {
            _player.Pause();
            _timer.Stop();
            IsPlaying = false;
        }
        else
        {
            _player.Play();
            _timer.Start();
            IsPlaying = true;

            // === ДОБАВЛЯЕМ СЛУШАНИЕ СЮДА ===
            if (!_hasRecordedListen && CurrentUser != null && BookModel != null)
            {
                var listenService = new BookListenService();
                var already = await listenService.HasUserListenedAsync(CurrentUser.Id, BookModel.Id);
                if (!already)
                {
                    await listenService.AddListenAsync(CurrentUser.Id, BookModel.Id);
                    await BookDetailsStats();
                    HasListened = true;
                    _hasRecordedListen = true;
                    Console.WriteLine("Прослушивание записано при первом воспроизведении");
                }
                else
                {
                    HasListened = true;
                    _hasRecordedListen = true;
                    Console.WriteLine("Пользователь уже слушал книгу");
                }
            }
        }
    }




    private async void UpdatePosition()
    {
        if (_player == null) return;

        CurrentPosition = TimeSpan.FromSeconds(_player.CurrentPosition);
        ManualSliderValue = _player.CurrentPosition;

        if (!_hasRecordedListen && _player.CurrentPosition >= 5) // например, 5 секунд
        {
            _hasRecordedListen = true;

            if (CurrentUser != null && BookModel != null)
            {
                var listenService = new BookListenService();
                var already = await listenService.HasUserListenedAsync(CurrentUser.Id, BookModel.Id);
                if (!already)
                {
                    await listenService.AddListenAsync(CurrentUser.Id, BookModel.Id);
                    await BookDetailsStats(); 
                }
            }
        }

        if (!_player.IsPlaying)
        {
            IsPlaying = false;
            _timer.Stop();
        }
    }


    [RelayCommand]
    private void ChangeSpeed()
    {
        PlaybackSpeed = PlaybackSpeed switch
        {
            1.0 => 1.25,
            1.25 => 1.5,
            1.5 => 0.75,
            0.75 => 1.0,
            _ => 1.0
        };

        if (_player != null)
            _player.Volume = 1.0; // Set volume/speed accordingly if supported
    }

    [RelayCommand]
    private void Rewind(object parameter)
    {
        if (_player == null || parameter == null) return;

        if (int.TryParse(parameter.ToString(), out int seconds))
        {
            var newPos = Clamp(_player.CurrentPosition + seconds, 0, _player.Duration);
            _player.Seek(newPos);
            CurrentPosition = TimeSpan.FromSeconds(newPos);
            ManualSliderValue = newPos;
        }
    }

    public async Task BookDetailsStats()
    {
        if (BookModel == null)
        {
            BookDetailsStatsText = "Нет данных";
            return;
        }

        try
        {
            var service = new BookListenService();
            int count = await service.GetUsersWhoListenedToBookAsync(BookModel.Id);
            BookDetailsStatsText = $"{count}";
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Ошибка в BookDetailsStats: {ex.Message}");
            BookDetailsStatsText = "Ошибка загрузки статистики";
        }
    }
    private async Task CheckIfUserListened()
    {
        if (CurrentUser == null || BookModel == null) return;

        var listenService = new BookListenService();
        HasListened = await listenService.HasUserListenedAsync(CurrentUser.Id, BookModel.Id);
    }

    [RelayCommand]
    private async Task MarkAsListened()
    {
        if (CurrentUser == null || BookModel == null) return;

        var listenService = new BookListenService();
        var already = await listenService.HasUserListenedAsync(CurrentUser.Id, BookModel.Id);

        if (!already)
        {
            await listenService.AddListenAsync(CurrentUser.Id, BookModel.Id);
            HasListened = true;
            await BookDetailsStats();
            Console.WriteLine("Пользователь отметил книгу как прослушанную");
        }
        else
        {
            HasListened = true;
            Console.WriteLine("Пользователь уже слушал книгу ранее");
        }
    }

    private double Clamp(double val, double min, double max) =>
        Math.Max(min, Math.Min(max, val));
}
