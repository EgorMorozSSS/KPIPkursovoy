using SQLite;
using Course.Models;

namespace Course.DataServices
{
    internal class BookListenService
    {
        private readonly SQLiteAsyncConnection _db;

        public BookListenService()
        {
            string dbPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), "DemoBookDB.db3");
            _db = new SQLiteAsyncConnection(dbPath);
            _db.CreateTableAsync<BookListenRecord>().Wait();
        }

        public async Task AddListenAsync(int userId, int bookId)
        {
            var existing = await _db.Table<BookListenRecord>()
                .Where(r => r.UserId == userId && r.BookId == bookId)
                .FirstOrDefaultAsync();

            if (existing == null)
            {
                await _db.InsertAsync(new BookListenRecord
                {
                    UserId = userId,
                    BookId = bookId,
                    ListenedAt = DateTime.UtcNow
                });
            }
        }

        public async Task<bool> HasUserListenedAsync(int userId, int bookId)
        {
            var record = await _db.Table<BookListenRecord>()
                .Where(r => r.UserId == userId && r.BookId == bookId)
                .FirstOrDefaultAsync();

            return record != null;
        }

        public async Task<int> GetUsersWhoListenedToBookAsync(int bookId)
        {
            var records = await _db.Table<BookListenRecord>()
                .Where(r => r.BookId == bookId)
                .ToListAsync();

            return records.Select(r => r.UserId).Distinct().Count();
        }
    }
}
