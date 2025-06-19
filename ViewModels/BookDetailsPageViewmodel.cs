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
    private readonly BookListenService _listenService = new();
    private readonly ReviewService _reviewService = new();
    private IAudioPlayer _player;
    private IDispatcherTimer _timer;
    private User _currentUser;
    private bool _hasRecordedListen = false;

    [ObservableProperty] private Book _bookModel;
    [ObservableProperty] private TimeSpan _currentPosition;
    [ObservableProperty] private TimeSpan _duration;
    [ObservableProperty] private bool _isPlaying;
    [ObservableProperty] private double _playbackSpeed = 1.0;
    [ObservableProperty] private double _manualSliderValue;
    [ObservableProperty] private string _newReviewContent;
    [ObservableProperty] private ObservableCollection<Review> _reviews;
    [ObservableProperty] private string _formattedTags;
    [ObservableProperty] private string _bookDetailsStatsText = "Loading...";
    [ObservableProperty] private bool hasListened;

    public BookDetailsPageViewmodel(IAudioManager audioManager)
    {
        _audioManager = audioManager;

        _timer = Application.Current.Dispatcher.CreateTimer();
        _timer.Interval = TimeSpan.FromMilliseconds(500);
        _timer.Tick += async (_, _) => await UpdatePosition();

        Reviews = new ObservableCollection<Review>();
    }

    public User CurrentUser
    {
        get => _currentUser;
        set
        {
            SetProperty(ref _currentUser, value);
            _ = TryInitializeBookStats();
        }
    }

    partial void OnBookModelChanged(Book value)
    {
        LoadAudio(value.AudioFilePath);
        LoadReviews();
        FormattedTags = value.Tags;
        _ = CheckIfUserListened();
        _ = TryInitializeBookStats();
    }

    private async Task TryInitializeBookStats()
    {
        if (BookModel != null && CurrentUser != null)
        {
            await UpdateBookStatsDisplay();
        }
    }

    private async Task UpdateBookStatsDisplay()
    {
        try
        {
            int count = await _listenService.GetUsersWhoListenedToBookAsync(BookModel.Id);
            MainThread.BeginInvokeOnMainThread(() =>
            {
                BookDetailsStatsText = $"{count}";
            });
        }
        catch
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                BookDetailsStatsText = "Ошибка загрузки";
            });
        }
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
        if (string.IsNullOrWhiteSpace(NewReviewContent) || BookModel == null || CurrentUser == null)
            return;

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
            await _reviewService.AddReviewAsync(review);
            NewReviewContent = string.Empty;

            if (Reviews == null)
                Reviews = new ObservableCollection<Review>();

            MainThread.BeginInvokeOnMainThread(() =>
            {
                Reviews.Insert(0, review);
            });
        }
        catch
        {
            // Ошибка при добавлении отзыва
        }
    }

    [RelayCommand]
    private async Task MarkAsListened()
    {
        if (BookModel == null || CurrentUser == null || HasListened)
            return;

        var already = await _listenService.HasUserListenedAsync(CurrentUser.Id, BookModel.Id);
        if (!already)
        {
            await _listenService.AddListenAsync(CurrentUser.Id, BookModel.Id);
            HasListened = true;

            int count = await _listenService.GetUsersWhoListenedToBookAsync(BookModel.Id);
            MainThread.BeginInvokeOnMainThread(() =>
            {
                BookDetailsStatsText = $"{count}";
            });
        }
        else
        {
            HasListened = true;
        }
    }

    private void LoadAudio(string path)
    {
        if (!File.Exists(path)) return;

        var fileStream = File.OpenRead(path);
        _player = _audioManager.CreatePlayer(fileStream);

        Duration = TimeSpan.FromSeconds(_player.Duration);
        ManualSliderValue = 0;
        CurrentPosition = TimeSpan.Zero;
    }

    [RelayCommand]
    private void PlayPause()
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
        }
    }

    private async Task UpdatePosition()
    {
        if (_player == null) return;

        CurrentPosition = TimeSpan.FromSeconds(_player.CurrentPosition);
        ManualSliderValue = _player.CurrentPosition;

        if (!_hasRecordedListen && _player.CurrentPosition >= 5)
        {
            _hasRecordedListen = true;

            if (CurrentUser != null && BookModel != null)
            {
                bool already = await _listenService.HasUserListenedAsync(CurrentUser.Id, BookModel.Id);
                if (!already)
                {
                    await _listenService.AddListenAsync(CurrentUser.Id, BookModel.Id);
                    HasListened = true;

                    int count = await _listenService.GetUsersWhoListenedToBookAsync(BookModel.Id);
                    MainThread.BeginInvokeOnMainThread(() =>
                    {
                        BookDetailsStatsText = $"{count}";
                    });
                }
                else
                {
                    HasListened = true;
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
            _player.Volume = 1.0;
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

    private async Task CheckIfUserListened()
    {
        if (CurrentUser == null || BookModel == null) return;

        HasListened = await _listenService.HasUserListenedAsync(CurrentUser.Id, BookModel.Id);
    }

    private double Clamp(double val, double min, double max) =>
        Math.Max(min, Math.Min(max, val));
}
