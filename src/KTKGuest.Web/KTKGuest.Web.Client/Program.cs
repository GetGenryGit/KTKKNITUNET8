using Blazored.LocalStorage;
using Blazored.SessionStorage;
using Blazored.Toast;
using KTKGuest.Shared.Abstractions.Services;
using KTKGuest.Shared.Services;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;

var builder = WebAssemblyHostBuilder.CreateDefault(args);

string baseUrl = string.Empty;
#if DEBUG
        baseUrl = "https://localhost:7061/";
#else
        baseUrl = "https://ktkknitu.ru/";
#endif
builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri(baseUrl) });
builder.Services.AddTransient<IHttpService, HttpService>();
builder.Services.AddTransient<ISchedulesService, SchedulesService>();
builder.Services.AddTransient<IDictionariesService, DictionariesService>();
builder.Services.AddTransient<IFeedbackService, FeedbackService>();
builder.Services.AddBlazoredToast();
builder.Services.AddBlazoredSessionStorage();
builder.Services.AddBlazoredLocalStorage();

await builder.Build().RunAsync();
