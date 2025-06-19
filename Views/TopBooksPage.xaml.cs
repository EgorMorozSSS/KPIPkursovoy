using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CommunityToolkit.Mvvm.ComponentModel;
using Course.ViewModels;

namespace Course.Views
{
    public partial class TopBooksPage : ContentPage
    {
        public TopBooksPage(TopBooksPageViewModel viewModel)
        {
            InitializeComponent();
            BindingContext = viewModel;
        }
    }
}