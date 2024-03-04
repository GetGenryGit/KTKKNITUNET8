using Microsoft.AspNetCore.Mvc;
using static Google.Apis.Requests.BatchRequest;

namespace KTKGuest.Web.Controllers;

[ApiController]
[Route("api/teacher_activity")]
public class TeacherActivityContoller(ITeacherActivityService teacherActivityService, ILogsService logsService)
    : ControllerBase
{
    private readonly ITeacherActivityService _teacherActivityService = teacherActivityService;
    private readonly ILogsService _logsService = logsService;

    [HttpGet("{date}")]
    [Authorize(Roles = "А.П., Ф.П.А.")]
    public async Task<IActionResult> Get(DateTime date)
    {
        var response = new APIResponse();

        try
        {
            response = await _teacherActivityService.GetTeacherActivityByDate(date);

            return Ok(response);
        }
        catch (Exception ex) 
        {

#if DEBUG
            response.Message = ex.Message;
#else
            response.Message = $"Произошла ошибка на стороне сервера, при получение учительской активности!";
#endif
            return BadRequest(response);
        }

    }

    [HttpPost("{date}/{teacher}")]
    [Authorize(Roles = "А.П., Ф.П.А.")]
    public async Task<IActionResult> Post(DateTime date, string teacher, List<ScheduleItem> lessons)
    {
        var response = new APIResponse();

        try
        {
            response = await _teacherActivityService.AddTeacherActivityForDate(date, teacher, lessons);

            var isSuccessLoged = await _logsService.SaveLog($"Успешно обновлена информации о не проведенных парах преподавателем {teacher}", "Ф.П.А.");

            return Ok(response);
        }
        catch (Exception ex)
        {
            var isSuccessLoged = await _logsService.SaveLog($"Произошла ошибка при попытке обновить информацию о не проведенных парах учителем {teacher}", "Ф.П.А.");
#if DEBUG
            response.Message = ex.Message;
#else
            response.Message = $"Произошла ошибка при попытке обновить информацию о не проведенных парах учителем {teacher}!";
#endif
            return BadRequest(response);
        }
    }
}
