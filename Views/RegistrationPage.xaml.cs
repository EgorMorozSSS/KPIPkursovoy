using Course.ViewModels;
using CommunityToolkit.Mvvm.ComponentModel;
using Course.ViewModels;

namespace Course.Views
{
    public partial class RegistrationPage : ContentPage
    {
        public RegistrationPage(RegistrationViewModel viewModel)
        {
            InitializeComponent();
            BindingContext = viewModel;
        }
    }
}