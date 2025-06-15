using System.Collections.Generic;
using System.Threading.Tasks;
using Course.Models;

namespace Course.DataServices
{
    public interface IAdminService
    {
        Task<List<Book>> GetAllBooksAsync();
        Task<bool> DeleteBookAsync(int bookId);
    }
}
