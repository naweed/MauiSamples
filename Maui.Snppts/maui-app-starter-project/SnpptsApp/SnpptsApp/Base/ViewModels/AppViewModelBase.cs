namespace SnpptsApp.Base.ViewModels;

public partial class AppViewModelBase : ViewModelBase
{
    public INavigation NavigationService { get; set; }
    public Page PageService { get; set; }

    protected IApiService _appApiService { get; set; }
    protected ISettingsService _appSettingsService { get; set; }

    public AppViewModelBase(IApiService appApiService, ISettingsService appSettingsService)
        : base()
    {
        _appApiService = appApiService;
        _appSettingsService = appSettingsService;
    }

    [RelayCommand]
    protected async Task NavigateBack() =>
        await NavigationService.PopAsync();

    [RelayCommand]
    protected async Task CloseModal() =>
        await NavigationService.PopModalAsync();
}

