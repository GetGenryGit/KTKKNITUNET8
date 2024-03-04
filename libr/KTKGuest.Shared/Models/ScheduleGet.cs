using System.Text.Json.Serialization;

namespace KTKGuest.Shared.Models;

public class ScheduleGet
{
    [JsonPropertyName("start_at")]
    public List<TimeSpan> StartAt { get; set; } = new List<TimeSpan>();
    [JsonPropertyName("end_at")]
    public List<TimeSpan> EndAt { get; set; } = new List<TimeSpan>();
    [JsonPropertyName("schedule_list_data")]
    public List<ScheduleItem> ScheduleListData { get; set; } = new List<ScheduleItem>();
    [JsonPropertyName("schedule_obj_data")]
    public ScheduleObj? ScheduleObjData { get; set; }
}

public class ScheduleItem
{
    [JsonPropertyName("class_index")]
    public int ClassIndex { get; set; }
    [JsonPropertyName("teacher")]
    public string Teacher { get; set; }
    [JsonPropertyName("subject")]
    public string Subject { get; set; }
    [JsonPropertyName("collective")]
    public string Collective { get; set; }
    [JsonPropertyName("classroom")]
    public string Classroom { get; set; }
    [JsonPropertyName("sub_group")]
    public int SubGroup { get; set; }
}
