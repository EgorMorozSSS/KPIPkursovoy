using Course.Models;
using SQLite;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Course.DataServices
{
    public class AuthorService : IAuthorService
    {
        private SQLiteAsyncConnection _dbConnection;

        private async Task SetupDatabase()
        {
            if (_dbConnection == null)
            {
                string dbPath = Path.Combine(
                    Environment.GetFolderPath(
                        Environment.SpecialFolder.LocalApplicationData),
                    "DemoBookDB.db3");

                _dbConnection = new SQLiteAsyncConnection(dbPath);
                await _dbConnection.CreateTableAsync<Author>();
                await _dbConnection.CreateTableAsync<Book>();
            }
        }

        public async Task<List<Author>> GetAuthorsAsync()
        {
            await SetupDatabase();
            return await _dbConnection.Table<Author>().ToListAsync();
        }

        public async Task<Author> GetAuthorAsync(int id)
        {
            await SetupDatabase();
            return await _dbConnection.Table<Author>()
                .Where(a => a.Id == id)
                .FirstOrDefaultAsync();
        }

        public async Task AddAuthorAsync(Author author)
        {
            await SetupDatabase();
            await _dbConnection.InsertAsync(author);
        }

        public async Task UpdateAuthorAsync(Author author)
        {
            await SetupDatabase();
            await _dbConnection.UpdateAsync(author);
        }

        public async Task DeleteAuthorAsync(Author author)
        {
            await SetupDatabase();
            await _dbConnection.DeleteAsync(author);
        }
    }
}