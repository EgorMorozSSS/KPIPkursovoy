using Course.Models;
using SQLite;
using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;

namespace Course.DataServices
{
    public class AdminService : IAdminService
    {
        private readonly SQLiteAsyncConnection _db;

        public AdminService()
        {
            string dbPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), "DemoBookDB.db3");
            _db = new SQLiteAsyncConnection(dbPath);
        }

        public async Task<List<Book>> GetAllBooksAsync()
        {
            await _db.CreateTableAsync<Book>();
            return await _db.Table<Book>().ToListAsync();
        }

        public async Task<bool> DeleteBookAsync(int bookId)
        {
            await _db.CreateTableAsync<Book>();
            var book = await _db.Table<Book>().FirstOrDefaultAsync(b => b.Id == bookId);
            if (book == null) return false;
            await _db.DeleteAsync(book);
            return true;
        }
    }
}
