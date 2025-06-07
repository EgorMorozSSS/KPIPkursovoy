using System.Globalization;

namespace Course.Converters
{
    public class BoolToPlayPauseIconConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return (bool)value ? "&#xf04c;" : "&#xf04b;"; // Иконки паузы и воспроизведения
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}