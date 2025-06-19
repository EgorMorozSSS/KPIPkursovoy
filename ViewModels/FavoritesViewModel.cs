using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Course.DataServices;
using Course.Models;
using Course.Views;
using System.Collections.ObjectModel;
using System.Threading.Tasks;

namespace Course.ViewModels
{
    public partial class FavoritesViewModel : ObservableObject
    {
        private readonly IBookService _bookService;
        private readonly IAuthService _authService;

        [ObservableProperty]
        private ObservableCollection<Book> _favoriteBooks = new();

        public FavoritesViewModel(IBookService bookService, IAuthService authService)
        {
            _bookService = bookService;
            _authService = authService;
            LoadFavorites();
        }

        private async void LoadFavorites()
        {
            var user = await _authService.GetCurrentUserAsync();
            var books = await _bookService.GetBooksAsync();
            var favorites = books.Where(b => b.IsFavorite).ToList();
            FavoriteBooks = new ObservableCollection<Book>(favorites);

        }
        [RelayCommand]
        private async Task NavigateToDetails(Book book)
        {
            if (book == null) return;

            var navigationParameter = new Dictionary<string, object>
    {
        { "ViewBookDetails", book }
    };
            await Shell.Current.GoToAsync(nameof(BookDetailsPage), navigationParameter);
        }

    }
}
