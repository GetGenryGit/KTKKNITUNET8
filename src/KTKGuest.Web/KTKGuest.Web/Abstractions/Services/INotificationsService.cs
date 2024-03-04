namespace KTKGuest.Web.Abstractions.Services;

public interface INotificationsService
{
    Task<string> SendAll(string title, string body);

}
