using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Course.DataServices;
using Course.Views;
using Course.Models;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;

namespace Course.ViewModels
{
    public partial class LoginViewModel : ObservableValidator
    {
        private User _currentUser;
        [ObservableProperty]
        [Required(ErrorMessage = "Email is required")]
        [EmailAddress(ErrorMessage = "Invalid email format")]
        private string _email;

        [ObservableProperty]
        [Required(ErrorMessage = "Password is required")]
        private string _password;

        private readonly IAuthService _authService;

        public LoginViewModel(IAuthService authService)
        {
            _authService = authService;
        }

        [RelayCommand]
        private async Task Login()
        {
            ValidateAllProperties();

            if (HasErrors)
            {
                var errors = string.Join("\n", GetErrors().Select(e => e.ErrorMessage));
                await Shell.Current.DisplayAlert("Validation Error", errors, "OK");
                return;
            }

            var user = await _authService.LoginAsync(_email, _password);

            if (user == null)
            {
                await Shell.Current.DisplayAlert("Login Failed", "Invalid credentials", "OK");
                return;
            }

            _currentUser = user;

            if (_currentUser.IsAdmin)
            {
                await Shell.Current.DisplayAlert("Admin Login", "Welcome, admin!", "OK");
                await Shell.Current.GoToAsync(nameof(AdminDashboardPage));
            }
            else
            {
                await Shell.Current.GoToAsync(nameof(BooklistHomePage));
            }
        }

        [RelayCommand]
        private async Task NavigateToRegistration()
        {
            await Shell.Current.GoToAsync(nameof(RegistrationPage));
        }
    }
}
