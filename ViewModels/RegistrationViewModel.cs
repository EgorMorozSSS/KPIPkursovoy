using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Course.DataServices;
using Course.Extensions;
using Course.Models;
using Course.Views;
using System.ComponentModel.DataAnnotations;
using System.Data;
using Course.Extensions;
using System.Threading.Tasks;

namespace Course.ViewModels
{
    public partial class RegistrationViewModel : ObservableValidator
    {
        [ObservableProperty]
        private string _name;

        // RegistrationViewModel.cs
        [ObservableProperty]
        [Required(ErrorMessage = "Email is required")]
        [EmailAddress(ErrorMessage = "Invalid email format")]
        private string _email;

        [ObservableProperty]
        [Required(ErrorMessage = "Password is required")]
        [MinLength(6, ErrorMessage = "Password must be at least 6 characters")]
        private string _password;
        public bool HasEmailErrors => GetErrors(nameof(Email)).Any();
        public string EmailError => GetErrors(nameof(Email)).FirstOrDefault()?.ErrorMessage;
        [ObservableProperty]
        private UserRoleExtensions.UserRoleItem _selectedRole;

        // Добавим список ролей
        [ObservableProperty]
        private IList<UserRoleExtensions.UserRoleItem> _roles;
        private readonly IAuthService _authService;

        public RegistrationViewModel(IAuthService authService)
        {
            _authService = authService;
            _roles = UserRoleExtensions.Values.ToList();
            _selectedRole = _roles.First(); // Установить значение по умолчанию
        }
        [RelayCommand]
        private async Task Register()
        {

            ValidateAllProperties();

            if (HasErrors)
            {
                var errors = string.Join("\n", GetErrors().Select(e => e.ErrorMessage));
                await Shell.Current.DisplayAlert("Validation Error", errors, "OK");
                return;
            }

            var user = new User
            {
                Name = _name,
                Email = _email,
                PasswordHash = _password,
                Role = _selectedRole.Value
            };

            var result = await _authService.RegisterAsync(user);

            if (result)
            {
                await Shell.Current.GoToAsync(nameof(BooklistHomePage));
            }

        }

        [RelayCommand]
        private async Task NavigateToHome()
        {
            await Shell.Current.GoToAsync(nameof(BooklistHomePage));
        }

        [RelayCommand]
        private async Task NavigateToLogin()
        {
            await Shell.Current.GoToAsync(nameof(LoginPage));
        }

    }
}