namespace SnpptsApp.Services;

public interface IApiService
{
    Task<SnpptsResult> GetSnppts();
}

