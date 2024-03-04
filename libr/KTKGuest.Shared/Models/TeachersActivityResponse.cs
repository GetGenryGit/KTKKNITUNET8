using System.Text.Json.Serialization;

namespace KTKGuest.Shared.Models;

public class TeachersActivityResponse
{
    [JsonPropertyName("schedule_get")]
    public ScheduleGet? ScheduleGet { get; set; }
    [JsonPropertyName("missed_lessons")]
    public List<ScheduleItem> MissedLessons { get; set; } = [];
}