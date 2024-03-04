using KTKGuest.Shared.Enums;

namespace KTKGuest.Shared.Abstractions.Services;

public interface ISchedulesService
{
    bool IsScheduleNotPublished { get; }
    Task<ScheduleObj> GetScheduleAsync(DateTime date, ScheduleType type, string valueSchedule);
}