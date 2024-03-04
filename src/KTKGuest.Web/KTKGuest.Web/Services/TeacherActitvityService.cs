

namespace KTKGuest.Web.Services;

public class TeacherActitvityService(ITeacherActivityRepository teacherActivityRepository, ISchedulesService schedulesService)
    : ITeacherActivityService
{
    private readonly ITeacherActivityRepository _teacherActivityRepository = teacherActivityRepository;
    private readonly ISchedulesService _schedulesService = schedulesService; 

    public async Task<APIResponse> GetTeacherActivityByDate(DateTime date)
    {
        var response = new TeachersActivityResponse();

        var schedule = await _schedulesService.GetScheduleAsync(ScheduleType.None, date);
        var list = await _teacherActivityRepository.GetByDate(date);

        var scheduleResult = new List<ScheduleItem>();

        foreach (var item in list.DistinctBy(l => l.Teacher))
        {
            scheduleResult
                .AddRange(schedule.ScheduleListData.Where(l => l.Teacher == item.Teacher));
        }

        response.ScheduleGet = schedule;
        response.MissedLessons = list;

        response.ScheduleGet.ScheduleListData = scheduleResult;
        response.MissedLessons = list;

        return new APIResponse
        {
            Result = true,
            Message = $"Преподавательская активность за {date:dd.MM.yyyy} успешно получена!",
            Obj = response
        };
    }

    public async Task<APIResponse> AddTeacherActivityForDate(DateTime date, string teacher, List<ScheduleItem> lessons)
    {
        var resultInsertsRows = await _teacherActivityRepository.AddByDate(date, teacher, lessons);

        return new APIResponse
        {
            Result = true,
            Message = "Преподавательская активность успешно добавлена!",
        };
    }
}
