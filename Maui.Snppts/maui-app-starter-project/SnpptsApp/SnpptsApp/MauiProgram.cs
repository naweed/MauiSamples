using Microsoft.Maui.LifecycleEvents;
using SkiaSharp.Views.Maui.Controls.Hosting;

namespace SnpptsApp;

public static class MauiProgram
{
	public static MauiApp CreateMauiApp()
	{
		var builder = MauiApp.CreateBuilder();
		builder
			.UseMauiApp<App>()
            .UseSkiaSharp()
			.ConfigureFonts(fonts =>
			{
                fonts.AddFont("TitilliumWeb-Regular.ttf", "RegularFont");
                fonts.AddFont("TitilliumWeb-SemiBold.ttf", "MediumFont");
            })
            .ConfigureLifecycleEvents(events =>
            {
#if ANDROID
                events.AddAndroid(android => android.OnCreate((activity, bundle) => MakeStatusBarTranslucent(activity)));

                static void MakeStatusBarTranslucent(Android.App.Activity activity)
                {
                    activity.Window.SetFlags(Android.Views.WindowManagerFlags.LayoutNoLimits, Android.Views.WindowManagerFlags.LayoutNoLimits);

                    activity.Window.ClearFlags(Android.Views.WindowManagerFlags.TranslucentStatus);

                    activity.Window.SetStatusBarColor(Android.Graphics.Color.Transparent);
                    //activity.Window.SetFlags(Android.Views.WindowManagerFlags.Fullscreen, Android.Views.WindowManagerFlags.Fullscreen);
                }
#endif
            }); ;

        //RegisterServices
        RegisterServices(builder.Services);

		return builder.Build();
	}

    private static void RegisterServices(IServiceCollection services)
    {
        //Add Platform specific Dependencies
        services.AddSingleton<IConnectivity>(Connectivity.Current);

        //Register Cache Barrel
        Barrel.ApplicationId = Constants.ApplicationId;
        services.AddSingleton<IBarrel>(Barrel.Current);

        //Register Services

        //Register Settings Service
        services.AddSingleton<ISettingsService, AppSettingsService>();

        //Register API Service
        services.AddSingleton<IApiService, SnpptsApiService>();

        //Register View Models
        services.AddSingleton<StartPageViewModel>();
        services.AddTransient<SnippetDetailsPageViewModel>();
        services.AddTransient<AddNewSnippetPageViewModel>();
        services.AddSingleton<AboutPageViewModel>();
        services.AddSingleton<SettingsPageViewModel>();
        services.AddTransient<ImageViewerPageViewModel>();
    }
}

