namespace KTKGuest.Web.Services;

public class LogsService : ILogsService
{
    private readonly ILogsRepository _logsRepository;
    public LogsService(ILogsRepository logsRepository)
    {
        _logsRepository = logsRepository;
    }
    public Task<List<HistoryItem>> GetAll(string role)
        => _logsRepository.GetLogs(role);

    public async Task<bool> SaveLog(string message, string role)
    {
        int countRows = await _logsRepository.SaveLog(message, role);

        return countRows > 0;
    }

}
