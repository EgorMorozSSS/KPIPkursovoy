using Course.Models;
using SQLite;

namespace Course.DataServices
{
    public class BookService : IBookService
    {
        private SQLiteAsyncConnection BookDbConnection;

        public BookService() => SetupBookDatabase();

        private async void SetupBookDatabase()
        {
            if (BookDbConnection is null)
            {
                string dbPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), "DemoBookDB.db3");
                BookDbConnection = new SQLiteAsyncConnection(dbPath);
                await BookDbConnection.CreateTableAsync<Book>();
            }
        }

        public async Task<ServiceResponse> AddOrUpdateBookAsync(Book book)
        {
            if (book is null) return ErrorMessage(-1);
            if (book.Id == 0)
            {
                int responseId = await BookDbConnection.InsertAsync(book);
                return SuccessMessage(responseId);
            }

            int updateResponseCode = await BookDbConnection.UpdateAsync(book);
            return SuccessMessage(updateResponseCode);
        }

        public async Task<ServiceResponse> DeleteBookAsync(Book book)
        {
            if (book.Id > 0)
            {
                var result = await GetBookAsync(book.Id);
                if (result is null) return ErrorMessage(book.Id);

                int responseId = await BookDbConnection.DeleteAsync(book);
                return SuccessMessage(responseId);
            }
            return ErrorMessage(-1);
        }

        public async Task<ServiceResponse> DeleteBookAsync(int bookId)
        {
            var book = await GetBookAsync(bookId);
            if (book == null)
            {
                return ErrorMessage(bookId);
            }

            int responseId = await BookDbConnection.DeleteAsync(book);
            return SuccessMessage(responseId);
        }

        public async Task<Book> GetBookAsync(int id) => await BookDbConnection.Table<Book>().Where(_ => _.Id == id).FirstOrDefaultAsync();

        public async Task<List<Book>> GetBooksAsync() => await BookDbConnection.Table<Book>().ToListAsync();

        private static ServiceResponse SuccessMessage(int responseId) => new() { Flag = true, DatabaseResponseValue = responseId, Message = "Process Completed Successfully." };
        private static ServiceResponse ErrorMessage(int responseId) => new() { Flag = false, DatabaseResponseValue = responseId, Message = "Process failed... Please check and try again." };
        public async Task<ServiceResponse> ToggleFavoriteAsync(Book book)
        {
            book.IsFavorite = !book.IsFavorite;
            return await AddOrUpdateBookAsync(book);
        }

        public async Task<ServiceResponse> LikeBookAsync(Book book)
        {
            book.Likes += 1;
            return await AddOrUpdateBookAsync(book);
        }

    }
}
