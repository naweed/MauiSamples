namespace SnpptsApp.Services;

public partial class AppSettingsService : ObservableObject, ISettingsService
{
    private string _sortOrder;
    public string SortOrder
    {
        get
        {
            _sortOrder = Preferences.Get(nameof(SortOrder), "Latest");
            return _sortOrder;
        }
        set
        {
            SetProperty(ref _sortOrder, value);
            Preferences.Set(nameof(SortOrder), _sortOrder);
        }
    }
}