using CommunityToolkit.Maui;
using Course.DataServices;
using Course.ViewModels;
using Course.Views;
using Microsoft.Extensions.Logging;
using Plugin.Maui.Audio;
using Syncfusion.Maui.Core.Hosting;


namespace Course
{
    public static class MauiProgram
    {
        public static MauiApp CreateMauiApp()
        {
            var builder = MauiApp.CreateBuilder();
            builder
                .UseMauiApp<App>()
                .UseMauiCommunityToolkit()
                .UseMauiCommunityToolkitMediaElement()
                .ConfigureSyncfusionCore()
                .ConfigureFonts(fonts =>
                {
                    fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
                    fonts.AddFont("OpenSans-Semibold.ttf", "OpenSansSemibold");
                });
            builder.Services.AddSingleton(AudioManager.Current);
            builder.Services.AddTransient<IBookService, BookService>();
            builder.Services.AddTransient<AddOrUpdateBookPageViewmodel>();
            builder.Services.AddTransient<AddOrUpdateBookPage>();
            builder.Services.AddTransient<BooklistHomePageViewmodel>();
            builder.Services.AddSingleton<BooklistHomePage>();
            builder.Services.AddSingleton<IAuthService, AuthService>();
            builder.Services.AddTransient<RegistrationViewModel>();
            builder.Services.AddTransient<RegistrationPage>();
            builder.Services.AddTransient<BookDetailsPageViewmodel>();
            builder.Services.AddTransient<BookDetailsPage>();
            builder.Services.AddTransient<LoginViewModel>();
            builder.Services.AddTransient<LoginPage>();
            builder.Services.AddTransient<UserProfilePage>();
            builder.Services.AddTransient<UserProfileViewModel>();
            builder.Services.AddSingleton<IAuthService, AuthService>();
            builder.Services.AddSingleton<IAdminService, AdminService>();
            builder.Services.AddTransient<AdminDashboardViewModel>();
            builder.Services.AddTransient<AdminDashboardPage>();
            builder.Services.AddTransient<FavoritesPage>();
            builder.Services.AddTransient<FavoritesViewModel>();


#if DEBUG
            builder.Logging.AddDebug();
#endif

            return builder.Build();
        }
    }
}
