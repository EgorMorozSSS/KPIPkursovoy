using CommunityToolkit.Maui.Alerts;
using CommunityToolkit.Maui.Core;
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Course.DataServices;
using Course.Models;
using Course.Views;
using MvvmHelpers;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows.Input;

namespace Course.ViewModels
{
    public partial class BooklistHomePageViewmodel : AddBookBaseViewModel
    {
        [ObservableProperty] private bool _gridVisibility;
        [ObservableProperty] private string _newReviewContent;
        [ObservableProperty] private ObservableCollection<Review> _reviews = new();
        [ObservableProperty] private Book _selectedBook;
        [ObservableProperty] private User _currentUser;
        [ObservableProperty] private string _searchText;
        [ObservableProperty] private bool _isAuthor;
        [ObservableProperty] private string _selectedGenre;
        [ObservableProperty]
        private int _newReviewRating = 5;  // По умолчанию 5
        public ObservableCollection<int> RatingOptions { get; } = new ObservableCollection<int> { 1, 2, 3, 4, 5 };
        private readonly BookListenService _bookListenService = new();
        private readonly ReviewService _reviewService = new();
        private readonly IBookService bookService;
        private readonly IAuthService _authService;
        private List<Book> AllBooks { get; set; } = new();

        public ObservableRangeCollection<Book> Books { get; set; } = new();
        public ObservableCollection<string> Genres { get; set; } = new()
        {
            "All", "Fiction", "Non-Fiction", "Fantasy", "Science Fiction",
            "Mystery", "Romance", "Thriller", "Horror", "Biography", "Self-Help"
        };

        public BooklistHomePageViewmodel(IBookService bookService, IAuthService authService)
        {
            this.bookService = bookService;
            _authService = authService;

            CheckUserRole();
            LoadCurrentUser();
        }

        private async void LoadCurrentUser()
        {
            _currentUser = await _authService.GetCurrentUserAsync();
        }

        private async void CheckUserRole()
        {
            var user = await _authService.GetCurrentUserAsync();
            IsAuthor = user?.Role == UserRole.Author;
        }

        [RelayCommand]
        private void SearchBooks()
        {
            var filteredBooks = AllBooks.Where(b =>
                string.IsNullOrWhiteSpace(SearchText) ||
                b.Title.Contains(SearchText, StringComparison.OrdinalIgnoreCase) ||
                b.Description.Contains(SearchText, StringComparison.OrdinalIgnoreCase)
            ).ToList();

            if (!string.IsNullOrEmpty(SelectedGenre) && SelectedGenre != "All")
                filteredBooks = filteredBooks.Where(b => b.Genre == SelectedGenre).ToList();

            Books.Clear();
            Books.AddRange(filteredBooks);
        }

        [RelayCommand]
        private async Task LoadBookFromDatabase()
        {
            GridVisibility = false;
            await Task.Delay(1000);

            var results = await bookService.GetBooksAsync(); // Загружаем все книги с сервера/БД

            if (results.Count > 0)
            {
                AllBooks = new();

                // Получаем текущего пользователя, чтобы узнать, прослушивал ли он каждую книгу
                var currentUser = await _authService.GetCurrentUserAsync();

                foreach (var book in results)
                {
                    // Количество уникальных пользователей, прослушавших книгу
                    var listenCount = await _bookListenService.GetUsersWhoListenedToBookAsync(book.Id);

                    // Проверка: слушал ли эту книгу текущий пользователь
                    var hasListened = await _bookListenService.HasUserListenedAsync(currentUser.Id, book.Id);

                    // Добавляем в список новую модель книги с дополнительной информацией
                    AllBooks.Add(new Book
                    {
                        Id = book.Id,
                        Title = book.Title,
                        Description = book.Description.Length > 30 ? book.Description.Substring(0, 30) + "..." : book.Description,
                        Image = book.Image,
                        Genre = book.Genre,
                        Likes = book.Likes,
                        IsFavorite = book.IsFavorite,

                        // 👇 Новые поля
                        ListenCount = listenCount,
                        HasUserListened = hasListened
                    });
                }

                FilterBooksByGenre(); // Фильтрация по жанру/поиску
            }

            GridVisibility = true;
        }

        [RelayCommand]
        private async Task ShowListenersInfo(Book book)
        {
            if (book == null) return;

            int count = await _bookListenService.GetUsersWhoListenedToBookAsync(book.Id);
            await Shell.Current.DisplayAlert("Прослушивания", $"Книгу прослушали {count} пользовател(ей).", "ОК");
        }

        [RelayCommand]
        private async Task NavigateToAddBookPage() => await Shell.Current.GoToAsync(nameof(AddOrUpdateBookPage), true);

        [RelayCommand]
        private async Task NavigateToDetails(Book bookModel)
        {
            if (bookModel == null) return;

            var desc = await bookService.GetBookAsync(bookModel.Id);
            var navigationParameter = new Dictionary<string, object>
            {
                { "ViewBookDetails", desc }
            };
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
                var desc = await bookService.GetBookAsync(bookToBeUpdated.Id);
                var navigationParameter = new Dictionary<string, object>
                {
                    { "UpdateBookData", desc }
                };
                await Shell.Current.GoToAsync(nameof(AddOrUpdateBookPage), navigationParameter);
            }
        }

        private static async void MakeToast(string message)
        {
            var toast = Toast.Make(message, ToastDuration.Long, 15);
            await toast.Show(CancellationToken.None);
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

        [RelayCommand]
        public async Task AddReview()
        {
            if (string.IsNullOrWhiteSpace(NewReviewContent) || SelectedBook == null || CurrentUser == null)
                return;

            int authorId = CurrentUser.Role == UserRole.Author ? CurrentUser.Id : 0;

            var review = new Review
            {
                BookId = SelectedBook.Id,
                AuthorId = authorId,
                Content = NewReviewContent,
                Rating = _newReviewRating, // Устанавливаем рейтинг
                CreatedAt = DateTime.UtcNow,
                BookTitle = SelectedBook.Title  // Для отображения в списке отзывов
            };

            try
            {
                await _reviewService.AddReviewAsync(review);
                NewReviewContent = string.Empty;
                _newReviewRating = 5; // Сбросить рейтинг после добавления
                Reviews.Insert(0, review);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error adding review: {ex.Message}");
            }
        }
        [RelayCommand]
        private async Task MarkAsListened(Book book)
        {
            if (book == null || _currentUser == null || book.HasUserListened)
                return;

            await _bookListenService.AddListenAsync(_currentUser.Id, book.Id);
            book.HasUserListened = true;
            book.ListenCount += 1;

            // Обновим UI
            var index = Books.IndexOf(book);
            if (index >= 0)
            {
                Books.RemoveAt(index);
                Books.Insert(index, book);
            }

            await Toast.Make("Книга отмечена как прослушанная").Show();
        }

        partial void OnSelectedBookChanged(Book value)
        {
            if (value != null)
                LoadReviewsForSelectedBook();
        }

        [RelayCommand]
        public async Task BookSelected(Book book)
        {
            SelectedBook = book;
            await LoadReviewsForSelectedBook();
        }

        public async Task LoadReviewsForSelectedBook()
        {
            if (SelectedBook == null) return;
            var reviews = await _reviewService.GetReviewsForBookAsync(SelectedBook.Id);

            foreach (var rev in reviews)
            {
                rev.BookTitle = SelectedBook.Title;
            }

            Reviews = new ObservableCollection<Review>(reviews);
        }

        [RelayCommand]
        private async Task ToggleFavorite(Book book)
        {
            if (book == null) return;
            await bookService.ToggleFavoriteAsync(book);
            await LoadBookFromDatabase(); 
        }

        [RelayCommand]
        private async Task LikeBook(Book book)
        {
            if (book == null) return;
            await bookService.LikeBookAsync(book);
            await LoadBookFromDatabase(); 
        }

    }
}
