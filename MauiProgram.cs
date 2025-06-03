using CommunityToolkit.Maui;
using Microsoft.Extensions.Logging;
using Syncfusion.Maui.Core.Hosting;
using Course.ViewModels;
using Course.Views;
using Course.DataServices;


namespace Course
{
    public static class MauiProgram
    {
        public static MauiApp CreateMauiApp()
        {
            var builder = MauiApp.CreateBuilder();
            builder
                .UseMauiApp<App>()
                .UseMauiCommunityToolkitMediaElement()
                .UseMauiCommunityToolkit()
                .ConfigureSyncfusionCore()
                .ConfigureFonts(fonts =>
                {
                    fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
                    fonts.AddFont("OpenSans-Semibold.ttf", "OpenSansSemibold");
                });
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

#if DEBUG
            builder.Logging.AddDebug();
#endif

            return builder.Build();
        }
    }
}
