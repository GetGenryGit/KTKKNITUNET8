namespace KTKGuest.Web.Abstractions.Services;

public interface ISchedulesService
{
    Task<ScheduleGet> GetScheduleAsync(ScheduleType type, DateTime date, string? collective = null);
    Task<ScheduleItem> AddScheduleAsync(DateTime date, ScheduleGet data);
    Task<bool> DeleteScheduleAsync(DateTime date);
}
