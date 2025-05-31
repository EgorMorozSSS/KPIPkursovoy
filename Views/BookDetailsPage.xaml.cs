using Course.ViewModels;

namespace Course.Views;

public partial class BookDetailsPage : ContentPage
{
	public BookDetailsPage(BookDetailsPageViewmodel bookDetailsPageViewmodel)
	{
		InitializeComponent();
        BindingContext = bookDetailsPageViewmodel;
    }
}