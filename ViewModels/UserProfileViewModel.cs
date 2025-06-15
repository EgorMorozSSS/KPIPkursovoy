using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Course.DataServices;
using Course.Models;
using System;
using System.Threading.Tasks;
using Course.Views;

namespace Course.ViewModels
{
    public partial class UserProfileViewModel : ObservableObject
    {
        private readonly IAuthService _authService;

        [ObservableProperty]
        private string _name;

        [ObservableProperty]
        private string _email;

        [ObservableProperty]
        private string _avatarImage = "default_avatar.png";

        public UserProfileViewModel(IAuthService authService)
        {
            _authService = authService ?? throw new ArgumentNullException(nameof(authService));
            LoadUserProfile();
            _isDarkTheme = App.Current.UserAppTheme == AppTheme.Dark;
        }

        private async Task LoadUserProfile()
        {
            try
            {
                var user = await _authService.GetCurrentUserAsync();
                if (user == null) return;

                Name = user.Name;
                Email = user.Email;
                AvatarImage = user.Avatar ?? "default_avatar.png";
            }
            catch (Exception ex)
            {
                await Shell.Current.DisplayAlert("Error", $"Failed to load profile: {ex.Message}", "OK");
            }
        }

        [RelayCommand]
        private async Task ChangeAvatar()
        {
            try
            {
                var result = await FilePicker.Default.PickAsync(new PickOptions
                {
                    PickerTitle = "Select avatar",
                    FileTypes = FilePickerFileType.Images
                });

                if (result != null)
                {
                    AvatarImage = result.FullPath;
                    await _authService.UpdateAvatarAsync(AvatarImage);
                }
            }
            catch (Exception ex)
            {
                await Shell.Current.DisplayAlert("Error", ex.Message, "OK");
            }
        }

        [RelayCommand]
        private async Task SaveProfile()
        {
            try
            {
                var user = new User
                {
                    Name = Name,
                    Email = Email,
                    Avatar = AvatarImage
                };

                var success = await _authService.UpdateUserProfileAsync(user);
                var message = success ? "Profile updated" : "Update failed";
                await Shell.Current.DisplayAlert("Info", message, "OK");
            }
            catch (Exception ex)
            {
                await Shell.Current.DisplayAlert("Error", ex.Message, "OK");
            }
        }

        [RelayCommand]
        private async Task NavigateToFavorites()
        {
            await Shell.Current.GoToAsync(nameof(FavoritesPage));
        }
        private bool _isDarkTheme;

        public bool IsDarkTheme
        {
            get => _isDarkTheme;
            set
            {
                SetProperty(ref _isDarkTheme, value);
                App.Current.UserAppTheme = value ? AppTheme.Dark : AppTheme.Light;
            }
        }

    }
}