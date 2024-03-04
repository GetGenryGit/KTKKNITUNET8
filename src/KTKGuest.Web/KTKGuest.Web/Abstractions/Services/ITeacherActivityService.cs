namespace KTKGuest.Web.Abstractions.Services;

public interface ITeacherActivityService
{
    Task<APIResponse> GetTeacherActivityByDate(DateTime date);
    Task<APIResponse> AddTeacherActivityForDate(DateTime date, string teacher, List<ScheduleItem> lessons);
}
