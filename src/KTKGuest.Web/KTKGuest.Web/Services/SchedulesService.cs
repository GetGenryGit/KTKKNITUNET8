namespace KTKGuest.Web.Services;

public class SchedulesService : ISchedulesService
{
    private readonly ISchedulesRepository _schedulesRepository;
    public SchedulesService(ISchedulesRepository schedulesRepository)
    {
        _schedulesRepository = schedulesRepository;
    }
    public async Task<ScheduleItem> AddScheduleAsync(DateTime date, ScheduleGet data)
    {
        /*int deletedRows =*/ await _schedulesRepository.DeleteScheduleAsync(date);
        return await _schedulesRepository.AddScheduleAsync(date, data);
    }

    public async Task<bool> DeleteScheduleAsync(DateTime date)
    {
        int rows = await _schedulesRepository.DeleteScheduleAsync(date);
        return rows > 0;
    }

    public async Task<ScheduleGet> GetScheduleAsync(ScheduleType type, DateTime date, string value)
    {
        switch (type) 
        {
            case ScheduleType.None:
                return await _schedulesRepository.GetScheduleAsync(date);
            case ScheduleType.Collectives:
                ArgumentException.ThrowIfNullOrWhiteSpace(value);
                return await _schedulesRepository.GetScheduleByCollectiveAsync(date, value);
            case ScheduleType.Teachers:
                ArgumentException.ThrowIfNullOrWhiteSpace(value);
                return await _schedulesRepository.GetScheduleByTeacherAsync(date, value);
            case ScheduleType.Classrooms:
                ArgumentException.ThrowIfNullOrWhiteSpace(value);
                return await _schedulesRepository.GetScheduleByClassroomAsync(date, value);
            default:
                throw new ArgumentException(nameof(type));
        }
    }
}
