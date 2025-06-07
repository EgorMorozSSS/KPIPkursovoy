using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Course.Models;
using SQLite;

namespace Course.DataServices
{
    public class ReviewService
    {
        private SQLiteAsyncConnection _db;

        public ReviewService()
        {
            string path = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), "DemoBookDB.db3");
            _db = new SQLiteAsyncConnection(path);
            _db.CreateTableAsync<Review>().Wait();
        }

        public async Task<List<Review>> GetReviewsForBookAsync(int bookId) =>
            await _db.Table<Review>().Where(r => r.BookId == bookId).OrderByDescending(r => r.CreatedAt).ToListAsync();

        public async Task AddReviewAsync(Review review) =>
            await _db.InsertAsync(review);
    }
}
