using Course.ViewModels;

namespace Course.Views
{
    public partial class FavoritesPage : ContentPage
    {
        public FavoritesPage(FavoritesViewModel viewModel)
        {
            InitializeComponent();
            BindingContext = viewModel;
        }
    }
}
