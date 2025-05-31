using Course.Models;

namespace Course.DataServices
{
    public interface IBookService
    {
        Task<ServiceResponse> AddOrUpdateBookAsync(Book book);
        Task<ServiceResponse> DeleteBookAsync(Book book);
        Task<List<Book>> GetBooksAsync();
        Task<Book> GetBookAsync(int id);
        Task<ServiceResponse> DeleteBookAsync(int bookId);
    }
}
