﻿using Course.Views;

namespace Course
{
    public partial class AppShell : Shell
    {
        public AppShell()
        {
            InitializeComponent();
            Routing.RegisterRoute(nameof(BooklistHomePage), typeof(BooklistHomePage));
            Routing.RegisterRoute(nameof(RegistrationPage), typeof(RegistrationPage));
            Routing.RegisterRoute(nameof(LoginPage), typeof(LoginPage));
            Routing.RegisterRoute(nameof(AddOrUpdateBookPage), typeof(AddOrUpdateBookPage));
            Routing.RegisterRoute(nameof(BookDetailsPage), typeof(BookDetailsPage));
            Routing.RegisterRoute(nameof(UserProfilePage), typeof(UserProfilePage));
        }
    }
}
