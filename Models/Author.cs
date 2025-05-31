using SQLite;

namespace Course.Models
{
    public class Author
    {
        [PrimaryKey, AutoIncrement]
        public int Id { get; set; }
        public string Name { get; set; }
        public string Biography { get; set; }
        public DateTime BirthDate { get; set; }

        [Ignore] // Не сохраняется в БД
        public List<Book> Books { get; set; } = new();
    }
}