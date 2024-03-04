using KTKGuest.Shared.Abstractions.Services;
using KTKGuest.Shared.Constants;
using KTKGuest.Shared.Enums;
using System.Linq;
using System.Text.Json;

namespace KTKGuest.Shared.Services;

public class SchedulesService : ISchedulesService
{
    private readonly IHttpService _httpService;
    public SchedulesService(IHttpService httpService)
    {
        _httpService = httpService;
    }
    public bool IsScheduleNotPublished { get; private set; }
    private ScheduleObj convertCollectiveSchedule(ScheduleGet scheduleRaw, string valueSchedule)
    {
        var scheduleResult = new ScheduleObj();

        if (valueSchedule != "Не выбрано")
        {
            var scheduleItemObj = new ScheduleItemObj { Title = valueSchedule };
            var scheduleItemTitleList = scheduleRaw.ScheduleListData;

            for (int i = 0; i < scheduleRaw.StartAt.Count; i++)
            {
                var lessonContainer = new LessonItemObj { Index = (i + 1), StartAt = scheduleRaw.StartAt[i], EndAt = scheduleRaw.EndAt[i] };

                var lessonsIndexList = scheduleItemTitleList.Where(l => l.ClassIndex == (i + 1));

                if (lessonsIndexList != null)
                {
                    foreach (var lesson in lessonsIndexList)
                    {
                        var lessonItem = new ItemObj
                        {
                            Title1 = lesson.Subject,
                            Title2 = lesson.Classroom,
                            Title3 = lesson.Teacher,
                            SubGroup = lesson.SubGroup,
                        };
                        lessonContainer.Items.Add(lessonItem);
                    }
                }
                else
                {
                    lessonContainer.Items.Add(new ItemObj());
                }
                scheduleItemObj.LessonItems.Add(lessonContainer);
            }

            scheduleResult.ScheduleItems.Add(scheduleItemObj);
        }
        else
        {
            var collectivesList = scheduleRaw.ScheduleListData.OrderBy(s => s.Collective).Select(s => s.Collective).Distinct().ToList();
            foreach (var group in collectivesList)
            {
                var scheduleItemObj = new ScheduleItemObj { Title = group };
                var scheduleItemTitleList = scheduleRaw.ScheduleListData.Where(l => l.Collective == group);

                for (int i = 0; i < scheduleRaw.StartAt.Count; i++)
                {
                    var lessonContainer = new LessonItemObj { Index = (i + 1), StartAt = scheduleRaw.StartAt[i], EndAt = scheduleRaw.EndAt[i] };

                    var lessonsIndexList = scheduleItemTitleList.Where(l => l.ClassIndex == (i + 1));

                    if (lessonsIndexList != null)
                    {
                        foreach (var lesson in lessonsIndexList)
                        {
                            var lessonItem = new ItemObj
                            {
                                Title1 = lesson.Subject,
                                Title2 = lesson.Classroom,
                                Title3 = lesson.Teacher,
                                SubGroup = lesson.SubGroup,
                            };
                            lessonContainer.Items.Add(lessonItem);
                        }
                    }
                    else
                    {
                        lessonContainer.Items.Add(new ItemObj());
                    }

                    scheduleItemObj.LessonItems.Add(lessonContainer);
                }

                scheduleResult.ScheduleItems.Add(scheduleItemObj);
            }
        }

        return scheduleResult;
    }
    private ScheduleObj convertTeacherSchedule(ScheduleGet scheduleRaw, string valueSchedule)
    {
        var scheduleResult = new ScheduleObj();

        if (valueSchedule != "Не выбрано")
        {
            var scheduleItemObj = new ScheduleItemObj { Title = valueSchedule };
            var scheduleItemTitleList = scheduleRaw.ScheduleListData;

            for (int i = 0; i < scheduleRaw.StartAt.Count; i++)
            {
                var lessonContainer = new LessonItemObj { Index = (i + 1), StartAt = scheduleRaw.StartAt[i], EndAt = scheduleRaw.EndAt[i], };
                var lessonsIndexList = scheduleItemTitleList.Where(l => l.ClassIndex == (i + 1));

                if (lessonsIndexList != null)
                {
                    foreach (var lesson in lessonsIndexList)
                    {
                        var lessonItem = new ItemObj
                        {
                            Title1 = lesson.Collective,
                            Title2 = lesson.Classroom,
                            Title3 = lesson.Subject,
                            SubGroup = 0,
                        };

                        lessonContainer.Items.Add(lessonItem);
                    }
                }
                else
                {
                    lessonContainer.Items.Add(new ItemObj());
                }

                scheduleItemObj.LessonItems.Add(lessonContainer);
            }
            scheduleResult.ScheduleItems.Add(scheduleItemObj);
        }
        else
        {
            var teachersList = scheduleRaw.ScheduleListData.OrderBy(s => s.Teacher).Select(s => s.Teacher).Distinct().ToList();
            foreach (var teacher in teachersList)
            {
                var scheduleItemObj = new ScheduleItemObj { Title = teacher };

                var scheduleItemTitleList = scheduleRaw.ScheduleListData.Where(l => l.Teacher == teacher);

                for (int i = 0; i < scheduleRaw.StartAt.Count; i++)
                {
                    var lessonContainer = new LessonItemObj { Index = (i + 1), StartAt = scheduleRaw.StartAt[i], EndAt = scheduleRaw.EndAt[i] };
                    var lessonsIndexList = scheduleItemTitleList.Where(l => l.ClassIndex == (i + 1));

                    if (lessonsIndexList != null)
                    {
                        foreach (var lesson in lessonsIndexList)
                        {

                            var lessonItem = new ItemObj
                            {
                                Title1 = lesson.Collective,
                                Title2 = lesson.Classroom,
                                Title3 = lesson.Subject,
                                SubGroup = 0,
                            };
                            lessonContainer.Items.Add(lessonItem);

                        }
                    }
                    else
                    {
                        lessonContainer.Items.Add(new ItemObj());
                    }
                    scheduleItemObj.LessonItems.Add(lessonContainer);
                }
                scheduleResult.ScheduleItems.Add(scheduleItemObj);
            }
        }

        return scheduleResult;
    }
    private ScheduleObj convertClassroomSchedule(ScheduleGet scheduleRaw, string valueSchedule)
    {
        var scheduleResult = new ScheduleObj();

        if (valueSchedule != "Не выбрано")
        {
            var scheduleItemObj = new ScheduleItemObj { Title = valueSchedule };

            var scheduleItemTitleList = scheduleRaw.ScheduleListData;

            for (int i = 0; i < scheduleRaw.StartAt.Count; i++)
            {
                var lessonContainer = new LessonItemObj { Index = (i + 1), StartAt = scheduleRaw.StartAt[i], EndAt = scheduleRaw.EndAt[i] };

                var lessonsIndexList = scheduleItemTitleList.Where(l => l.ClassIndex == (i + 1));

                if (lessonsIndexList != null)
                {
                    foreach (var lesson in lessonsIndexList)
                    {

                        var lessonItem = new ItemObj
                        {
                            Title1 = lesson.Teacher,
                            Title2 = lesson.Collective,
                            Title3 = lesson.Subject,
                            SubGroup = 0,
                        };

                        lessonContainer.Items.Add(lessonItem);

                    }
                }
                else
                {
                    lessonContainer.Items.Add(new ItemObj());
                }
                scheduleItemObj.LessonItems.Add(lessonContainer);
            }
            scheduleResult.ScheduleItems.Add(scheduleItemObj);
        }
        else
        {
            var classroomsList = scheduleRaw.ScheduleListData.OrderBy(s => s.Classroom).Select(s => s.Classroom).Distinct().ToList();
            foreach (var classroom in classroomsList)
            {
                var scheduleItemObj = new ScheduleItemObj { Title = classroom };

                var scheduleItemTitleList = scheduleRaw.ScheduleListData.Where(l => l.Classroom == classroom);

                for (int i = 0; i < scheduleRaw.StartAt.Count; i++)
                {
                    var lessonContainer = new LessonItemObj { Index = (i + 1), StartAt = scheduleRaw.StartAt[i], EndAt = scheduleRaw.EndAt[i] };

                    var lessonsIndexList = scheduleItemTitleList.Where(l => l.ClassIndex == (i + 1));

                    if (lessonsIndexList != null)
                    {
                        foreach (var lesson in lessonsIndexList)
                        {

                            var lessonItem = new ItemObj
                            {
                                Title1 = lesson.Teacher,
                                Title2 = lesson.Collective,
                                Title3 = lesson.Subject,
                                SubGroup = 0,
                            };

                            lessonContainer.Items.Add(lessonItem);

                        }
                    }
                    else
                    {
                        lessonContainer.Items.Add(new ItemObj());
                    }

                    scheduleItemObj.LessonItems.Add(lessonContainer);
                }

                scheduleResult.ScheduleItems.Add(scheduleItemObj);
            }
        }

        return scheduleResult;
    }

    private ScheduleObj convertScheduleList(ScheduleGet scheduleGet, ScheduleType type, string valueSchedule)
    {
        IsScheduleNotPublished = scheduleGet.StartAt.Count < 1;

        switch (type)
        {
            case ScheduleType.Collectives:
                return convertCollectiveSchedule(scheduleGet, valueSchedule);
            case ScheduleType.Teachers:
                return convertTeacherSchedule(scheduleGet, valueSchedule);
            case ScheduleType.Classrooms:
                return convertClassroomSchedule(scheduleGet, valueSchedule);
            default:
                throw new Exception(nameof(type));
        }
    }
    public async Task<ScheduleObj> GetScheduleAsync(DateTime date, ScheduleType type, string valueSchedule)
    {
        string parameters = $"?date={date:yyyy-MM-dd}";

        if (valueSchedule != "Не выбрано")
           parameters += $"&type={type}&value={valueSchedule}";
        else
           parameters += $"&type=None";

        var response = await _httpService.Get(APIConstants.GetSchedules + parameters);
        var rawSchedule = JsonSerializer.Deserialize<ScheduleGet>(response.Obj.ToString());
        return convertScheduleList(rawSchedule, type, valueSchedule);
    }
}
