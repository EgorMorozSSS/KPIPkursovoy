using Course.ViewModels;
using Microsoft.Maui.Controls;

namespace Course.Views
{
    public partial class UserProfilePage : ContentPage
    {
        public UserProfilePage(UserProfileViewModel viewModel)
        {
            InitializeComponent();
            BindingContext = viewModel;
        }
    }
}