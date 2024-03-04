using Blazored.LocalStorage;
using Blazored.SessionStorage;
using Blazored.Toast;
using KTKGuest.Shared.Abstractions.Services;
using KTKGuest.Shared.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents()
    .AddInteractiveWebAssemblyComponents();

builder.Services.AddServerSideBlazor().AddCircuitOptions(o =>
{
#if DEBUG
    o.DetailedErrors = true;
#endif
});

builder.Services.Configure<JWTSettings>(builder.Configuration.GetSection("JWTSettings"));

builder.Services.AddTransient<IJWTService, JWTService>();
builder.Services.AddScoped<IAuthService, AuthService>();
builder.Services.AddScoped<INotificationsService, NotificationService>();
builder.Services.AddScoped<ILogsService, LogsService>();
builder.Services.AddScoped<KTKGuest.Web.Abstractions.Services.IDictionariesService, KTKGuest.Web.Services.DictionariesService>();
builder.Services.AddScoped<KTKGuest.Web.Abstractions.Services.ISchedulesService, KTKGuest.Web.Services.SchedulesService>();
builder.Services.AddScoped<IUsersService, UsersService>();
builder.Services.AddScoped<ITeacherActivityService, TeacherActitvityService>();

builder.Services.AddScoped<IUsersRepository, UsersRepository>();
builder.Services.AddScoped<IRefreshSessionsRepository, RefreshSessionsRepository>();
builder.Services.AddScoped<ISchedulesRepository, SchedulesRepository>();
builder.Services.AddScoped<ICollectivesRepositoty, CollectivesRepository>();
builder.Services.AddScoped<ITeachersRepository, TeachersRepository>();
builder.Services.AddScoped<IClassroomsRepository, ClassroomsRepository>();
builder.Services.AddScoped<ISubjectsRepository, SubjectsRepository>();
builder.Services.AddScoped<IFeedbacksRepository, FeedBacksRepository>();
builder.Services.AddScoped<ILogsRepository, LogsRepository>();
builder.Services.AddScoped<ITeacherActivityRepository, TeacherActivityRepository>();

builder.Services.AddControllersWithViews();

// Секретные фразы которые знает только сервер
var secretKey = builder.Configuration.GetSection("JWTSettings:SecretKey").Value;
var issuer = builder.Configuration.GetSection("JWTSettings:Issuer").Value;
var audience = builder.Configuration.GetSection("JWTSettings:Audience").Value;
var signinKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secretKey));

builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.RequireHttpsMetadata = false;
    options.SaveToken = true;
    options.TokenValidationParameters = new()
    {
        ValidIssuer = issuer,
        ValidAudience = audience,
        IssuerSigningKey = signinKey,
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateIssuerSigningKey = true,
        ValidateLifetime = true,
        ClockSkew = TimeSpan.FromMinutes(5)
    };
});

builder.Services.AddAuthorization();

string baseUrl = string.Empty;
#if DEBUG
    baseUrl = "https://localhost:7061/";
#else
    baseUrl = "https://ktkknitu.ru/";
#endif
builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri(baseUrl) });
builder.Services.AddTransient<IHttpService, HttpService>();
builder.Services.AddTransient<KTKGuest.Shared.Abstractions.Services.ISchedulesService, KTKGuest.Shared.Services.SchedulesService>();
builder.Services.AddTransient<KTKGuest.Shared.Abstractions.Services.IDictionariesService, KTKGuest.Shared.Services.DictionariesService>();
builder.Services.AddTransient<IFeedbackService, FeedbackService>();
builder.Services.AddBlazoredToast();

builder.Services.AddBlazoredToast();
builder.Services.AddBlazoredSessionStorage();
builder.Services.AddBlazoredLocalStorage();

var app = builder.Build();


// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseWebAssemblyDebugging();
}
else
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseRouting();
app.MapControllers();

app.UseForwardedHeaders(new ForwardedHeadersOptions
{
    ForwardedHeaders = ForwardedHeaders.XForwardedFor |
    ForwardedHeaders.XForwardedProto
});

app.UseAuthentication();
app.UseAuthorization();

app.UseStaticFiles();
app.UseAntiforgery();

app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode()
    .AddInteractiveWebAssemblyRenderMode()
    .AddAdditionalAssemblies(typeof(Schedules).Assembly);

app.Run();
