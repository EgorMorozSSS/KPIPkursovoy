using Course.ViewModels;

namespace Course.Views;

public partial class AddOrUpdateBookPage : ContentPage
{
	public AddOrUpdateBookPage(AddOrUpdateBookPageViewmodel addOrUpdateBookPageViewmodel)
	{
		InitializeComponent();
        BindingContext = addOrUpdateBookPageViewmodel;
    }
}