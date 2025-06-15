using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SQLite;

namespace Course.Models
{
    public class Review
    {
        [PrimaryKey, AutoIncrement]
        public int Id { get; set; }

        [Indexed]
        public int BookId { get; set; }

        [Indexed]
        public int AuthorId { get; set; }

        public string Content { get; set; }

        public int Rating { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        [Ignore]
        public User Author { get; set; }
        [Ignore]
        public string BookTitle { get; set; }
    }
}
