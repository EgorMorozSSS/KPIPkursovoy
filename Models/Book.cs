using SQLite;

namespace Course.Models
{
    public class Book
    {
        [PrimaryKey, AutoIncrement]
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Image { get; set; }
        public bool IsRead { get; set; }
        public string Genre { get; set; }
        public int Likes { get; set; } = 0;           
        public bool IsFavorite { get; set; } = false;
        public int ListenCount { get; set; }
        public bool HasUserListened { get; set; } 

        public string Tags { get; set; }

        [Indexed]
        public int AuthorId { get; set; }

        [Ignore]
        public Author Author { get; set; }
        public string AudioFilePath { get; set; }
        [Ignore]
        public List<Review> Reviews { get; set; } = new();
    }
}
