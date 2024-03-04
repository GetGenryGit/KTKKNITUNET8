namespace KTKGuest.Web.Services;

public class NotificationService : INotificationsService
{
    public async Task<string> SendAll(string title, string body)
    {
        if (FirebaseApp.DefaultInstance == null)
        {
            FirebaseApp.Create(new AppOptions
            {
                Credential = GoogleCredential.FromFile("private_key_firebase.json")
            });
        }

        var message = new Message
        {
#if DEBUG
            Topic = "schedule_debug",
#else
            Topic = "schedule_release",
#endif
            Android = new()
            {
                Priority = Priority.High,
                Notification = new()
                {
                    ChannelId = "ru.com.ilyaoleynik.ktkguest.general",
                    Title = title,
                    Body = body
                }
            }
        };

        return await FirebaseMessaging.DefaultInstance.SendAsync(message);
    }
}
