using Course.ViewModels;

namespace Course.Views;

public partial class BooklistHomePage : ContentPage
{
    private readonly BooklistHomePageViewmodel booklistHomePageViewmodel;
    public BooklistHomePage(BooklistHomePageViewmodel booklistHomePageViewmodel)
	{
		InitializeComponent();
        BindingContext = booklistHomePageViewmodel;
        this.booklistHomePageViewmodel = booklistHomePageViewmodel;
    }

    protected override void OnAppearing()
    {
        base.OnAppearing();
        booklistHomePageViewmodel.LoadBookFromDatabaseCommand.Execute(this);
        UpdateToolbarItems();
        booklistHomePageViewmodel.PropertyChanged += HandleViewModelPropertyChanged;
    }

    protected override void OnDisappearing()
    {
        booklistHomePageViewmodel.PropertyChanged -= HandleViewModelPropertyChanged;
        base.OnDisappearing();
    }

    private void HandleViewModelPropertyChanged(object sender, System.ComponentModel.PropertyChangedEventArgs e)
    {
        if (e.PropertyName == nameof(BooklistHomePageViewmodel.IsAuthor))
        {
            UpdateToolbarItems();
        }
    }

    private void UpdateToolbarItems()
    {
        var existingAddButton = ToolbarItems.FirstOrDefault(t => t.Text == "+ Add Book");

        if (booklistHomePageViewmodel.IsAuthor)
        {
            if (existingAddButton == null)
            {
                var addButton = new ToolbarItem
                {
                    Text = "+ Add Book",
                    Command = booklistHomePageViewmodel.NavigateToAddBookPageCommand
                };
                ToolbarItems.Add(addButton);
            }
        }
        else
        {
            if (existingAddButton != null)
            {
                ToolbarItems.Remove(existingAddButton);
            }
        }
    }
}