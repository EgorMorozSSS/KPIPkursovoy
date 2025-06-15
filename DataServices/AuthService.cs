using Course.Models;
using SQLite;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Maui.Storage;

namespace Course.DataServices
{
    public class AuthService : IAuthService
    {
        private const string CurrentUserIdKey = "current_user_id";
        private SQLiteAsyncConnection _dbConnection;

        public AuthService()
        {
            Task.Run(async () => await LoadCurrentUser());
        }

        private async Task SetupDatabase()
        {
            if (_dbConnection == null)
            {
                string dbPath = Path.Combine(
                    Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData),
                    "DemoBookDB.db3");

                _dbConnection = new SQLiteAsyncConnection(dbPath);
                await _dbConnection.CreateTableAsync<User>();
            }
        }

        public async Task<bool> RegisterAsync(User user)
        {
            await SetupDatabase();
            if (await UserExistsAsync(user.Email))
                return false;

            user.PasswordHash = HashPassword(user.PasswordHash);
            await _dbConnection.InsertAsync(user);
            await SetCurrentUser(user);
            return true;
        }

        public async Task<User> LoginAsync(string email, string password)
        {
            await SetupDatabase();
            var user = await _dbConnection.Table<User>()
                .FirstOrDefaultAsync(u => u.Email == email);

            if (user == null || !VerifyPassword(password, user.PasswordHash))
                return null;

            await SetCurrentUser(user);
            return user;
        }

        public async Task<bool> UserExistsAsync(string email)
        {
            await SetupDatabase();
            return await _dbConnection.Table<User>()
                .Where(u => u.Email == email)
                .CountAsync() > 0;
        }

        private bool _isInitialized;
        private readonly SemaphoreSlim _initLock = new(1, 1);

        public async Task EnsureInitializedAsync()
        {
            if (_isInitialized) return;

            await _initLock.WaitAsync();
            try
            {
                if (!_isInitialized)
                {
                    await SetupDatabase();
                    await LoadCurrentUser();
                    await EnsureAdminExistsAsync();
                    _isInitialized = true;
                }
            }
            finally
            {
                _initLock.Release();
            }
        }
        public async Task<User> GetCurrentUserAsync()
        {
            await EnsureInitializedAsync();
            await SetupDatabase();
            var userId = Preferences.Get(CurrentUserIdKey, -1);
            return userId > 0
                ? await _dbConnection.Table<User>().FirstOrDefaultAsync(u => u.Id == userId)
                : null;
        }

        public async Task<bool> UpdateUserProfileAsync(User user)
        {
            await SetupDatabase();
            var existingUser = await GetCurrentUserAsync();
            if (existingUser == null) return false;

            existingUser.Name = user.Name;
            existingUser.Avatar = user.Avatar;

            if (!string.IsNullOrEmpty(user.PasswordHash) &&
                user.PasswordHash != existingUser.PasswordHash)
            {
                existingUser.PasswordHash = HashPassword(user.PasswordHash);
            }

            await _dbConnection.UpdateAsync(existingUser);
            await SetCurrentUser(existingUser);
            return true;
        }

        public async Task<bool> UpdateAvatarAsync(string avatarPath)
        {
            var user = await GetCurrentUserAsync();
            if (user == null) return false;

            user.Avatar = avatarPath;
            return await UpdateUserProfileAsync(user);
        }

        private string HashPassword(string password)
        {
            using var sha256 = SHA256.Create();
            var hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
            return Convert.ToBase64String(hashedBytes);
        }

        private bool VerifyPassword(string password, string storedHash)
        {
            return HashPassword(password) == storedHash;
        }

        private async Task LoadCurrentUser()
        {
            await SetupDatabase();
            var userId = Preferences.Get(CurrentUserIdKey, -1);
            if (userId > 0)
            {
                var user = await _dbConnection.Table<User>()
                    .FirstOrDefaultAsync(u => u.Id == userId);
                await SetCurrentUser(user);
            }
        }

        private async Task SetCurrentUser(User user)
        {
            Preferences.Set(CurrentUserIdKey, user?.Id ?? -1);
        }
        private async Task EnsureAdminExistsAsync()
        {
            await SetupDatabase();

            const string adminEmail = "admin@mail.ru";
            var adminExists = await UserExistsAsync(adminEmail);
            if (!adminExists)
            {
                var adminUser = new User
                {
                    Email = adminEmail,
                    PasswordHash = HashPassword("12345678"),
                    Name = "Admin",
                    Avatar = string.Empty,
                    IsAdmin = true,
                    Role = UserRole.Author
                };

                await _dbConnection.InsertAsync(adminUser);
            }
        }


    }
}