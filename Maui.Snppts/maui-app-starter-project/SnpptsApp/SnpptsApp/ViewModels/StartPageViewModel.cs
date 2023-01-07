namespace SnpptsApp.ViewModels;

public class StartPageViewModel : AppViewModelBase
{
    public StartPageViewModel(IApiService appApiService, ISettingsService appSettingsService)
        : base(appApiService, appSettingsService)
    {
        Title = "Mobile Snppts App";
    }
}

