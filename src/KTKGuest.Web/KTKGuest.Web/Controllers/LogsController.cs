namespace KTKGuest.Web.Controllers;

[Route("api/[controller]")]
[ApiController]
public class LogsController : ControllerBase
{
    private readonly ILogsRepository _logsRepository;
    public LogsController(ILogsRepository logsRepository)
    {
        _logsRepository = logsRepository;
    }

    [HttpGet("get")]
    public async Task<IActionResult> Get(string role)
    {
        var response = new APIResponse();

        try
        {
            var list = await _logsRepository.GetLogs(role);

            response.Result = true;
            response.Message = "Список с логами успешно получен!";
            response.Obj = list;

            return Ok(response);
        }
        catch (Exception ex)
        {
#if DEBUG
            response.Message = ex.Message;
#else
            response.Message = "Произошла ошибка на стороне сервера!";
#endif
            return BadRequest(ex.Message);
        }
    }
}
