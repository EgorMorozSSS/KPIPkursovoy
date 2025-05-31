using CommunityToolkit.Mvvm.ComponentModel;
using Course.Models;

namespace Course.ViewModels
{
    [QueryProperty(nameof(BookModel), "ViewBookDetails")]
    public partial class BookDetailsPageViewmodel : AddBookBaseViewModel
    {
        [ObservableProperty]
        private Book _bookModel;
    }
}
