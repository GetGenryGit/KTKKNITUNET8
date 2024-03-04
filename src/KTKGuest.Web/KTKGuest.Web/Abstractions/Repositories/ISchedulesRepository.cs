namespace KTKGuest.Web.Abstractions.Repositories;

public interface ISchedulesRepository
{
    Task<ScheduleGet> GetScheduleAsync(DateTime date);
    Task<ScheduleGet> GetScheduleByCollectiveAsync(DateTime date, string collective);
    Task<ScheduleGet> GetScheduleByTeacherAsync(DateTime date, string teacher);
    Task<ScheduleGet> GetScheduleByClassroomAsync(DateTime date, string classroom);
    Task<ScheduleItem> AddScheduleAsync(DateTime date, ScheduleGet data);
    Task<int> DeleteScheduleAsync(DateTime date);
}
