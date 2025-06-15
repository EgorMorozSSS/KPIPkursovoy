using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Course.ViewModels;
using Course.DataServices;

namespace Course.Views
{
    public partial class AdminDashboardPage : ContentPage
    {
        private readonly IBookService _bookService;
        private readonly IAuthService _authService;
        public AdminDashboardPage(AdminDashboardViewModel viewModel, IBookService bookService, IAuthService authService)
        {
            InitializeComponent();
            BindingContext = viewModel;
            _bookService = bookService;
            _authService = authService;
        }
        private async void OnAddBookClicked(object sender, EventArgs e)
        {
            var vm = new AddOrUpdateBookPageViewmodel(_bookService, _authService);
            await Navigation.PushAsync(new AddOrUpdateBookPage(vm));
        }

    }
}