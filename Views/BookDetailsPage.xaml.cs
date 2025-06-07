using Course.ViewModels;
using Microsoft.Maui.Controls;
using Plugin.Maui.Audio;

namespace Course.Views;

public partial class BookDetailsPage : ContentPage
{
    public BookDetailsPage(BookDetailsPageViewmodel viewModel)
    {
        InitializeComponent();
        BindingContext = viewModel;
    }

}
