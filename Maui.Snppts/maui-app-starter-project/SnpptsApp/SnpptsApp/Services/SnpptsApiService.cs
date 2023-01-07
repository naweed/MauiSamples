using Maui.Apps.Framework.Services;

namespace SnpptsApp.Services;

public class SnpptsApiService : RestServiceBase, IApiService
{
    //Constructor
    public SnpptsApiService(IConnectivity connectivity, IBarrel cacheBarrel)
        : base(connectivity, cacheBarrel) =>
        SetBaseURL(Constants.ApiServiceURL);

    public async Task<SnpptsResult> GetSnppts() =>
        await GetAsync<SnpptsResult>("snippets", 4); //Cached for 4 hours
}