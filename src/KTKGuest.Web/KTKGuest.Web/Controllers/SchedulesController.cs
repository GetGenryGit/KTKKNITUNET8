namespace KTKGuest.Web.Controllers;

[Route("api/[controller]")]
[ApiController]
public class SchedulesController(ISchedulesService scheduleService,
    ILogsService logsService) : ControllerBase
{
    private readonly ISchedulesService _scheduleService = scheduleService;
    private readonly ILogsService _logsService = logsService;

    [HttpGet("get")]
    public async Task<IActionResult> Get(DateTime date, ScheduleType type, string? value)
    {
        var response = new APIResponse();

        try
        {
            var scheduleResult = await _scheduleService.GetScheduleAsync(type, date, value);

            response.Result = true;
            response.Message = $"Расписание за {date:dd-MM-yyyy} успешно получено!";
            response.Obj = scheduleResult;

            return Ok(response);
        }
        catch (Exception ex) 
        {
#if DEBUG
            response.Message = ex.Message;
#else
            response.Message = "Произошла ошибка на стороне сервера, при получение расписания!";
#endif
            return BadRequest(response);
        }
    }

    [Authorize(Roles = "О.Р., А.П.")]
    [HttpPost("add/{date}")]
    public async Task<IActionResult> Add([FromRoute] DateTime date, [FromBody] ScheduleGet schedule)
    {
        var response = new APIResponse();

        try
        {
            var errorRow = await _scheduleService.AddScheduleAsync(date, schedule);
            if (errorRow != null) 
            {
                response.Message = "Произошла ошибка при публикации расписания!";
                response.Obj = errorRow;

                return Ok(response);
            }

            response.Result = true;
            response.Message = $"Расписание за {date:dd-MM-yyyy} успешно опубликованно!";

            var isSuccessLoged = await _logsService.SaveLog($"Расписание за {date:dd-MM-yyyy} успешно опубликованно!", "О.Р.");

            return Ok(response);
        }
        catch (Exception ex)
        {
            var isSuccessLoged = await _logsService.SaveLog($"При публикации расписания за {date:dd-MM-yyyy} произошла ошибка!", "О.Р.");

#if DEBUG
            response.Message = ex.Message;
#else
            response.Message = "Произошла ошибка на стороне сервера, при публикации расписания!";
#endif
            return BadRequest(response);
        }
    }

    [Authorize(Roles = "О.Р., А.П.")]
    [HttpDelete("delete_by_date/{date}")]
    public async Task<IActionResult> DeleteByDate([FromRoute] DateTime date)
    {
        var response = new APIResponse();

        try
        {
            await _scheduleService.DeleteScheduleAsync(date);

            response.Result = true;
            response.Message = $"Расписание за {date:dd-MM-yyyy} успешно удаленно!";

            var isSuccessLoged = await _logsService.SaveLog($"Расписание за {date:dd-MM-yyyy} успешно удалено!", "О.Р.");

            return Ok(response);    
        }
        catch (Exception ex)
        {
            var isSuccessLoged = await _logsService.SaveLog($"В процессе удаления расписания за {date:dd-MM-yyyy} произошла ошибка!", "О.Р.");

#if DEBUG
            response.Message = ex.Message;
#else
            response.Message = "Произошла ошибка на стороне сервера, при удаление расписания!";
#endif
            return BadRequest(response);
        }
    }
}
