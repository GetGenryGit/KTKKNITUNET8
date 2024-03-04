namespace KTKGuest.Web.Abstractions.Services;

public interface ILogsService
{
    Task<List<HistoryItem>> GetAll(string role);
    Task<bool> SaveLog(string message, string role);
}
