using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading.Tasks;
using Course.DataServices;
using Course.Models;

namespace Course.ViewModels
{
    public partial class AdminDashboardViewModel : ObservableObject
    {
        private readonly IAdminService _adminService;

        [ObservableProperty]
        private ObservableCollection<Book> books;

        [ObservableProperty]
        private Book selectedBook;

        public string Title => SelectedBook?.Title ?? string.Empty;
        public string Description => SelectedBook?.Description ?? string.Empty;
        public int Id => SelectedBook?.Id ?? 0;

        public AdminDashboardViewModel(IAdminService adminService)
        {
            _adminService = adminService;
            LoadBooksAsync();
        }

        private async void LoadBooksAsync()
        {
            var bookList = await _adminService.GetAllBooksAsync();
            Books = new ObservableCollection<Book>(bookList);
        }

        [RelayCommand]
        private async Task DeleteBook(int bookId)
        {
            bool deleted = await _adminService.DeleteBookAsync(bookId);
            if (deleted)
            {
                var book = Books.FirstOrDefault(b => b.Id == bookId);
                if (book != null)
                    Books.Remove(book);
            }
        }

        partial void OnSelectedBookChanged(Book value)
        {
            OnPropertyChanged(nameof(Title));
            OnPropertyChanged(nameof(Description));
            OnPropertyChanged(nameof(Id));
        }
    }
}
