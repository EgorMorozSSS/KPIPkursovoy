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
    private readonly User _currentUser;

    [ObservableProperty] private Book _bookModel;
    [ObservableProperty] private TimeSpan _currentPosition;
    [ObservableProperty] private TimeSpan _duration;
    [ObservableProperty] private bool _isPlaying;
    [ObservableProperty] private double _playbackSpeed = 1.0;
    [ObservableProperty] private double _manualSliderValue;
    [ObservableProperty] private string _newReviewContent;
    [ObservableProperty]
    ObservableCollection<Review> _reviews;


    private readonly ReviewService _reviewService = new();
    private IDispatcherTimer _timer;

    public BookDetailsPageViewmodel(IAudioManager audioManager, User currentUser)
    {
        _audioManager = audioManager;
        _currentUser = currentUser;

        _timer = Application.Current.Dispatcher.CreateTimer();
        _timer.Interval = TimeSpan.FromMilliseconds(500);
        _timer.Tick += (_, _) => UpdatePosition();
    }

    partial void OnBookModelChanged(Book value)
    {
        LoadAudio(value.AudioFilePath);
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
    private async Task AddReviewAsync()
    {
        if (string.IsNullOrWhiteSpace(_newReviewContent) || BookModel == null || _currentUser == null)
            return;

        int authorId = _currentUser.Role == UserRole.Author ? _currentUser.Id : 0;

        var review = new Review
        {
            BookId = BookModel.Id,
            AuthorId = authorId,
            Content = _newReviewContent,
            CreatedAt = DateTime.UtcNow
        };

        await _reviewService.AddReviewAsync(review);
        _newReviewContent = string.Empty;
        LoadReviews();
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

    private void UpdatePosition()
    {
        if (_player == null) return;

        CurrentPosition = TimeSpan.FromSeconds(_player.CurrentPosition);
        ManualSliderValue = _player.CurrentPosition;
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

    private double Clamp(double val, double min, double max) =>
        Math.Max(min, Math.Min(max, val));
}
