using CommunityToolkit.Maui.Alerts;
using CommunityToolkit.Maui.Core;
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Course.DataServices;
using Course.Models;
using Course.Views;
using MvvmHelpers;
using System.Collections.ObjectModel;
using System.Windows.Input;
using System.Linq;

namespace Course.ViewModels
{
    public partial class BooklistHomePageViewmodel : AddBookBaseViewModel
    {
        [ObservableProperty]
        private bool _gridVisibility;

        private readonly IBookService bookService;
        public ObservableRangeCollection<Book> Books { get; set; } = new();

        [ObservableProperty]
        private string _searchText;
        public BooklistHomePageViewmodel(IBookService bookService)
        {
            this.bookService = bookService;
            Title = "Netcode Book List";
            SearchText = string.Empty;
        }

        [RelayCommand]
        private void SearchBooks()
        {
            var filteredBooks = Books.Where(b =>
                (string.IsNullOrWhiteSpace(SearchText) ||
                 b.Title.Contains(SearchText, StringComparison.OrdinalIgnoreCase) ||
                 b.Description.Contains(SearchText, StringComparison.OrdinalIgnoreCase)) 
            ).ToList();

            Books.Clear();
            foreach (var book in filteredBooks)
            {
                Books.Add(book);
            }
        }



        [RelayCommand]
        private async Task LoadBookFromDatabase()
        {
            GridVisibility = false;
            await Task.Delay(1000);
            var results = await bookService.GetBooksAsync();

            if (results.Count > 0)
            {
                AllBooks = results.Select(book => new Book()
                {
                    Id = book.Id,
                    Title = book.Title,
                    Description = book.Description.Length > 30 ? book.Description.Substring(0, 30) + "..." : book.Description,
                    Image = book.Image,
                    Genre = book.Genre // Должно быть установлено!
                }).ToList();

                FilterBooksByGenre(); // После загрузки сразу отфильтровать
            }
            GridVisibility = true;


        }



        [RelayCommand]
        private async Task NavigateToAddBookPage() => await Shell.Current.GoToAsync(nameof(AddOrUpdateBookPage), true);

        [RelayCommand]
        private async Task NavigateToDetails(Book bookModel)
        {

            if (bookModel is null) return;

            //get full description
            var desc = await bookService.GetBookAsync(bookModel.Id);
            var navigationParameter = new Dictionary<string, object>();
            navigationParameter.Add("ViewBookDetails", desc);
            await Shell.Current.GoToAsync(nameof(BookDetailsPage), navigationParameter);
        }

        [RelayCommand]
        private async Task DeleteBookData(Book bookToBeDeleted)
        {
            bool answer = await Shell.Current.DisplayAlert("Подтвержаете удаление?", $"Вы точно хотите удалить {bookToBeDeleted.Title}?", "Да", "Нет");
            if (answer)
            {
                var result = await bookService.DeleteBookAsync(bookToBeDeleted);
                MakeToast(result.Message);
                await LoadBookFromDatabase();
            }
        }

        [RelayCommand]
        private async Task UpdateBookData(Book bookToBeUpdated)
        {
            bool answer = await Shell.Current.DisplayAlert("Confirm Update?", $"Are you sure you wanna update: {bookToBeUpdated.Title} ?", "Yes", "No");
            if (answer)
            {
                //get full description
                var desc = await bookService.GetBookAsync(bookToBeUpdated.Id);
                var navigationParameter = new Dictionary<string, object>();
                navigationParameter.Add("UpdateBookData", desc);
                await Shell.Current.GoToAsync(nameof(AddOrUpdateBookPage), navigationParameter);
            }
        }

        private static async void MakeToast(string message)
        {
            CancellationTokenSource cancellationTokenSource = new CancellationTokenSource();
            ToastDuration duration = ToastDuration.Long;
            double fontSize = 15;
            var toast = Toast.Make(message, duration, fontSize);
            await toast.Show(cancellationTokenSource.Token);
        }

        [ObservableProperty]
        private string _selectedGenre;
        private List<Book> AllBooks { get; set; } = new();


        public ObservableCollection<string> Genres { get; set; } = new ObservableCollection<string>
        {
            "All",
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

        public BooklistHomePageViewmodel()
        {
            LoadBooks();
        }
        

        private void LoadBooks()
        {
            Books.Clear();
            Books.Add(new Book { Title = "Book 1", Description = "A great fiction book", Genre = "Fiction", Image = "" });
            Books.Add(new Book { Title = "Book 2", Description = "A science book", Genre = "Science", Image = "" });
            Books.Add(new Book { Title = "Book 3", Description = "Fantasy adventure", Genre = "Fantasy", Image = "" });
            Books.Add(new Book { Title = "Book 4", Description = "Non-fiction story", Genre = "Non-Fiction", Image = "" });
        }

        [RelayCommand]
        private void FilterBooksByGenre()
        {
            if (AllBooks == null || AllBooks.Count == 0) return;

            var filteredBooks = AllBooks
                .Where(b => string.IsNullOrWhiteSpace(SearchText) || b.Title.Contains(SearchText, StringComparison.OrdinalIgnoreCase))
                .ToList();

            if (!string.IsNullOrEmpty(SelectedGenre) && SelectedGenre != "All")
            {
                filteredBooks = filteredBooks.Where(b => b.Genre == SelectedGenre).ToList();
            }

            Books.Clear();
            Books.AddRange(filteredBooks);
        }

        [RelayCommand]
        private async Task NavigateToProfile()
        {
            await Shell.Current.GoToAsync(nameof(UserProfilePage));
        }
        private readonly IAuthService _authService;

        [ObservableProperty]
        private bool _isAuthor;

        public BooklistHomePageViewmodel(IBookService bookService, IAuthService authService)
        {
            this.bookService = bookService;
            _authService = authService;
            CheckUserRole();
        }

        private async void CheckUserRole()
        {
            var user = await _authService.GetCurrentUserAsync();
            IsAuthor = user?.Role == UserRole.Author;
        }

    }
}

