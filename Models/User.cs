using SQLite;
using CommunityToolkit.Mvvm.ComponentModel;
using Course.ViewModels;

namespace Course.Models
{
    public class User
    {
        [PrimaryKey, AutoIncrement]
        public int Id { get; set; }
        public string Email { get; set; }
        public string PasswordHash { get; set; }
        public string Name { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public string Avatar { get; set; }
        public string AvatarPath { get; set; }
        public UserRole Role { get; set; }
    }
    public enum UserRole
    {
        User,
        Author
    }
}