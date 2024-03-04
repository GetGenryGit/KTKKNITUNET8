namespace KTKGuest.Web.Abstractions.Repositories;

public interface ITeacherActivityRepository
{
    Task<List<ScheduleItem>> GetByDate(DateTime date);
    Task<int> AddByDate(DateTime date, string teacher, List<ScheduleItem> lessons);
}
