using CommunityToolkit.Maui.Alerts;
using CommunityToolkit.Maui.Core;
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Course.DataServices;
using Course.Models;
using System.Collections.ObjectModel;
using System.Diagnostics;

namespace Course.ViewModels
{
    [QueryProperty(nameof(AddBookModel), "UpdateBookData")]
    public partial class AddOrUpdateBookPageViewmodel : AddBookBaseViewModel
    {
        private readonly IAuthService _authService;
        private readonly IBookService bookService;

        public AddOrUpdateBookPageViewmodel(IBookService bookService, IAuthService authService)
        {
            this.bookService = bookService;
            _authService = authService;
            Title = "Add Book Data";

            // Initialize with empty collections
            Errors = new ObservableCollection<Error>();
            Genres = new ObservableCollection<string>(DefaultGenres);
        }

        // Predefined genres
        private static readonly List<string> DefaultGenres = new()
        {
            "Fiction",
            "Non-Fiction",
            "Fantasy",
            "Science Fiction",
            "Mystery",
            "Romance",
            "Thriller",
            "Horror",
            "Biography",
            "Self-Help"
        };

        public ObservableCollection<string> Genres { get; }

        [ObservableProperty]
        private bool _showErrors;

        [ObservableProperty]
        private ImageSource _imageSourceFile;

        [ObservableProperty]
        private string _audioFileName;

        public ObservableCollection<Error> Errors { get; }

        // Initialize with non-null Book object
        [ObservableProperty]
        private Book _addBookModel = new Book();

        // Handle null assignments from QueryProperty
        partial void OnAddBookModelChanged(Book? oldValue, Book newValue)
        {
            if (newValue == null)
            {
                _addBookModel = new Book();
                OnPropertyChanged(nameof(AddBookModel));
            }
        }

        [RelayCommand]
        private async Task SelectImage()
        {
            try
            {
                var image = await FilePicker.PickAsync(new PickOptions
                {
                    PickerTitle = "Select Book Image",
                    FileTypes = FilePickerFileType.Images
                });
                if (image == null) return;

                byte[] imageByte;
                var stream = await image.OpenReadAsync();
                using (MemoryStream memory = new())
                {
                    await stream.CopyToAsync(memory);
                    imageByte = memory.ToArray();
                }

                var convertedImage = Convert.ToBase64String(imageByte);
                AddBookModel.Image = convertedImage;
                GetImage(convertedImage);
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"Image selection failed: {ex.Message}");
                await Shell.Current.DisplayAlert("Error", "Failed to select image", "OK");
            }
        }

        private void GetImage(string base64)
        {
            try
            {
                if (string.IsNullOrEmpty(base64))
                {
                    ImageSourceFile = null;
                    return;
                }

                var imgFromBase64 = Convert.FromBase64String(base64);
                ImageSourceFile = ImageSource.FromStream(() => new MemoryStream(imgFromBase64));
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"Image conversion failed: {ex.Message}");
                ImageSourceFile = null;
            }
        }

        [RelayCommand]
        private async Task SaveData()
        {
            try
            {
                var user = await _authService.GetCurrentUserAsync();
                if (user?.Role != UserRole.Author)
                {
                    await Shell.Current.DisplayAlert("Error", "Only authors can create books", "OK");
                    return;
                }
                AddBookModel.AuthorId = user.Id;

                Errors.Clear();
                ShowErrors = false;

                ValidateModel(AddBookModel);

                if (Errors.Count > 0)
                {
                    ShowErrors = true;
                    return;
                }

                var result = await bookService.AddOrUpdateBookAsync(AddBookModel);
                if (result.Flag)
                {
                    MakeToast(result.Message);
                    AddBookModel = new Book();
                    ImageSourceFile = null;
                    AudioFileName = null;
                    return;
                }

                Errors.Add(new Error() { Property = "Alert", Value = result.Message });
                ShowErrors = true;
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"Save failed: {ex.Message}");
                Errors.Add(new Error() { Property = "System Error", Value = ex.Message });
                ShowErrors = true;
            }
        }

        [RelayCommand]
        private async Task SelectAudio()
        {
            try
            {
                var audioFile = await FilePicker.PickAsync(new PickOptions
                {
                    PickerTitle = "Select Audio File",
                    FileTypes = new FilePickerFileType(new Dictionary<DevicePlatform, IEnumerable<string>>
                    {
                        { DevicePlatform.iOS, new[] { "public.audio" } },
                        { DevicePlatform.Android, new[] { "audio/*" } },
                        { DevicePlatform.WinUI, new[] { ".mp3", ".wav", ".m4a" } },
                        { DevicePlatform.macOS, new[] { "public.audio" } }
                    })
                });

                if (audioFile == null) return;

                var appDir = FileSystem.AppDataDirectory;
                var targetFile = Path.Combine(appDir, audioFile.FileName);

                using (var stream = await audioFile.OpenReadAsync())
                using (var fileStream = File.Create(targetFile))
                {
                    await stream.CopyToAsync(fileStream);
                }

                AddBookModel.AudioFilePath = targetFile;
                AudioFileName = audioFile.FileName;
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"Audio selection failed: {ex.Message}");
                await Shell.Current.DisplayAlert("Error", "Failed to select audio file", "OK");
            }
        }

        private void ValidateModel(Book validateBook)
        {
            if (string.IsNullOrWhiteSpace(validateBook.Title))
                Errors.Add(new Error() { Property = "Title", Value = "Book Title cannot be empty" });

            if (string.IsNullOrWhiteSpace(validateBook.Description))
            {
                Errors.Add(new Error() { Property = "Description", Value = "Book Description cannot be empty" });
            }
            else if (validateBook.Description.Length < 20)
            {
                Errors.Add(new Error() { Property = "Description", Value = "Minimum length must be 20 characters" });
            }

            if (string.IsNullOrWhiteSpace(validateBook.Image))
                Errors.Add(new Error() { Property = "Image", Value = "Book Image is required" });
        }

        private static async void MakeToast(string message)
        {
            try
            {
                CancellationTokenSource cancellationTokenSource = new();
                ToastDuration duration = ToastDuration.Long;
                double fontSize = 15;
                var toast = Toast.Make(message, duration, fontSize);
                await toast.Show(cancellationTokenSource.Token);
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"Toast failed: {ex.Message}");
            }
        }

        [RelayCommand]
        private async Task NavigateToHome() => await Shell.Current.GoToAsync("..", true);
    }
}