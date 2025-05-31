using CommunityToolkit.Mvvm.ComponentModel;
namespace Course.ViewModels
{
    public partial class AddBookBaseViewModel : ObservableObject
    {
        [ObservableProperty]
        private string _title;
    }
}
