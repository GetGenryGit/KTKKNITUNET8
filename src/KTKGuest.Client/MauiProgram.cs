using Blazored.LocalStorage;
using Blazored.SessionStorage;
using Blazored.Toast;
using KTKGuest.Shared.Abstractions.Services;
using KTKGuest.Shared.Services;
using Microsoft.Extensions.Logging;
using Microsoft.Maui.LifecycleEvents;
using Plugin.Firebase.Auth;
using Plugin.Firebase.Bundled.Shared;
using Plugin.Firebase.Crashlytics;

#if IOS
using Plugin.Firebase.Bundled.Platforms.iOS;
#else
using Plugin.Firebase.Bundled.Platforms.Android;
#endif

namespace KTKGuest.Client;

public static class MauiProgram
{
    public static MauiApp CreateMauiApp()
    {
        var builder = MauiApp.CreateBuilder();
        builder
            .RegisterFirebaseServices()
            .UseMauiApp<App>()
            .ConfigureFonts(fonts =>
            {
                fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
            });

        builder.Services.AddMauiBlazorWebView();

        string baseUrl = string.Empty;
#if DEBUG
        baseUrl = DeviceInfo.Platform == DevicePlatform.Android
                        ? "http://10.0.2.2:5132/"
                        : "https://localhost:7061/";
#else
        baseUrl = "https://ktkknitu.ru/";
#endif

        builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri(baseUrl)
        });
        builder.Services.AddTransient<IHttpService, HttpService>();
        builder.Services.AddTransient<ISchedulesService, SchedulesService>();
        builder.Services.AddTransient<IDictionariesService, DictionariesService>();
        builder.Services.AddTransient<IFeedbackService, FeedbackService>();
        builder.Services.AddBlazoredToast();
        builder.Services.AddBlazoredSessionStorage();
        builder.Services.AddBlazoredLocalStorage();


#if DEBUG
        builder.Services.AddBlazorWebViewDeveloperTools();
		builder.Logging.AddDebug();
#endif

        return builder.Build();
    }

    private static MauiAppBuilder RegisterFirebaseServices(this MauiAppBuilder builder)
    {
        builder.ConfigureLifecycleEvents(events =>
        {
#if IOS
            events.AddiOS(iOS => iOS.FinishedLaunching((app, launchOptions) => {
                CrossFirebase.Initialize(CreateCrossFirebaseSettings());
                return false;
            }));
#else
            events.AddAndroid(android => android.OnCreate((activity, _) =>
                CrossFirebase.Initialize(activity, CreateCrossFirebaseSettings())));
            CrossFirebaseCrashlytics.Current.SetCrashlyticsCollectionEnabled(true);
#endif
        });

        builder.Services.AddSingleton(_ => CrossFirebaseAuth.Current);
        return builder;
    }

    private static CrossFirebaseSettings CreateCrossFirebaseSettings()
    {
        return new CrossFirebaseSettings(isAuthEnabled: true,
        isCloudMessagingEnabled: true, isAnalyticsEnabled: true);
    }
}
