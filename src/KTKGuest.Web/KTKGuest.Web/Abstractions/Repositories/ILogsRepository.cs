namespace KTKGuest.Web.Abstractions.Repositories;

public interface ILogsRepository
{
    Task<List<HistoryItem>> GetLogs(string role);
    Task<int> SaveLog(string message, string role);
}
