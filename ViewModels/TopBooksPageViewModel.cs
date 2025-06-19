using CommunityToolkit.Mvvm.Input;
using Course.DataServices;
using Course.Models;
using Course.Views;
using MvvmHelpers;
using System.Collections.ObjectModel;

namespace Course.ViewModels
{
    public partial class TopBooksPageViewModel : BaseViewModel
    {
        private readonly IBookService _bookService;
        private readonly BookListenService _bookListenService = new();

        public ObservableCollection<Book> TopBooks { get; set; } = new();

        public TopBooksPageViewModel(IBookService bookService)
        {
            _bookService = bookService;
            LoadTopBooks();
        }

        private async Task LoadTopBooks()
        {
            var allBooks = await _bookService.GetBooksAsync();

            // Обнови ListenCount, если нужно получить из сервиса
            foreach (var book in allBooks)
            {
                book.ListenCount = await _bookListenService.GetUsersWhoListenedToBookAsync(book.Id);
            }

            var topBooks = allBooks
                .OrderByDescending(b => b.ListenCount) // Сортировка по убыванию
                .Take(3)
                .ToList();

            TopBooks.Clear();
            foreach (var book in topBooks)
                TopBooks.Add(book);
        }
        [RelayCommand]
        private async Task NavigateToDetails(Book book)
        {
            if (book == null)
                return;

            var navigationParameter = new Dictionary<string, object>
    {
        { "ViewBookDetails", book }
    };
            await Shell.Current.GoToAsync(nameof(BookDetailsPage), navigationParameter);
        }

    }
}
