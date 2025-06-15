using SQLite;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Course.Models;

namespace Course.DataServices
{
    internal class BookListenService
    {
        private SQLiteAsyncConnection _db;

        public BookListenService()
        {
            string dbPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), "DemoBookDB.db3");
            _db = new SQLiteAsyncConnection(dbPath);
            _db.CreateTableAsync<BookListenRecord>().Wait();
        }

        public async Task AddListenAsync(int userId, int bookId)
        {
            var alreadyListened = await _db.Table<BookListenRecord>()
                .Where(r => r.UserId == userId && r.BookId == bookId)
                .FirstOrDefaultAsync();

            if (alreadyListened == null)
            {
                await _db.InsertAsync(new BookListenRecord
                {
                    UserId = userId,
                    BookId = bookId,
                    ListenedAt = DateTime.UtcNow
                });
                Console.WriteLine("Слушание добавлено");
            }
            else
            {
                Console.WriteLine("Пользователь уже слушал эту книгу");
            }
        }

        public async Task<int> GetBooksListenedByUserAsync(int userId)
        {
            var records = await _db.Table<BookListenRecord>()
                .Where(r => r.UserId == userId)
                .ToListAsync();

            return records.Select(r => r.BookId).Distinct().Count();
        }

        public async Task<bool> HasUserListenedAsync(int userId, int bookId)
        {
            var existing = await _db.Table<BookListenRecord>()
                .Where(r => r.UserId == userId && r.BookId == bookId)
                .FirstOrDefaultAsync();

            return existing != null;
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
