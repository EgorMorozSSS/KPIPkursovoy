using Course.Models;

namespace Course.DataServices
{
    public interface IAuthService
    {
        Task<bool> RegisterAsync(User user);
        Task<User> LoginAsync(string email, string password);
        Task<bool> UserExistsAsync(string email);
        Task<User> GetCurrentUserAsync();
        Task<bool> UpdateAvatarAsync(string avatarPath);
        Task<bool> UpdateUserProfileAsync(User user);

    }
}