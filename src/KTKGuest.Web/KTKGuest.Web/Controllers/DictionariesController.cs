namespace KTKGuest.Web.Controllers;

[Route("api/[controller]")]
[ApiController]
public class DictionariesController : ControllerBase
{
    private readonly IDictionariesService _dictionariesService;
    private readonly ILogsService _logsService;
    public DictionariesController(IDictionariesService dictionariesService,
        ILogsService logsService)
    {
        _dictionariesService = dictionariesService;
        _logsService = logsService;
    }

    [HttpGet("get")]
    public async Task<IActionResult> Get(DictionaryType type)
    {
        var response = new APIResponse();

        try
        {
            var list = await _dictionariesService.GetActive(type);

            response.Result = true;
            response.Message = "Справочник успешно получен";
            response.Obj = list;

            return Ok(response);
        }
        catch (Exception ex) 
        {
#if DEBUG
            response.Message = ex.Message;
#else
            response.Message = "Произошла ошибка на стороне сервера, при получение справочников групп!";
#endif
            return BadRequest(response);
        }
    }

    [Authorize(Roles = "А.П., О.Р.")]
    [HttpGet("get_all")]
    public async Task<IActionResult> GetAll(DictionaryType type)
    {
        var response = new APIResponse();

        try
        {
            var list = await _dictionariesService.GetAll(type);

            response.Result = true;
            response.Message = "Справочник успешно получен";
            response.Obj = list;

            return Ok(response);
        }
        catch (Exception ex)
        {
#if DEBUG
            response.Message = ex.Message;
#else
            response.Message = "Произошла ошибка на стороне сервера, при получение справочников групп!";
#endif
            return BadRequest(response);
        }
    }

    [Authorize(Roles = "А.П., О.Р.")]
    [HttpPost("add/{type}")]
    public async Task<IActionResult> Add([FromRoute]DictionaryType type, [FromBody] List<string> list)
    {
        var response = new APIResponse();

        try
        {
            var result = await _dictionariesService.Add(type, list);
            if (!result)
            {
                response.Message = "Произошла ошибка при загрузке справочника!";
                response.Obj = type;

                return Ok(response);
            }

            response.Result = true;
            response.Message = "Справочник успешно загружен!";
            response.Obj = list;

            var isSuccessLoged = await _logsService.SaveLog($"Справочник успешно загружен {type}", "О.Р.");

            return Ok(response);
        }
        catch (Exception ex)
        {
            var isSuccessLoged = await _logsService.SaveLog($"Произошла ошибка при загрузке справочника {type}", "О.Р.");

#if DEBUG
            response.Message = ex.Message;
#else
            response.Message = $"Произошла ошибка на стороне сервера, при получение загрузке справочник {type}!";
#endif
            return BadRequest(response);
        }
    }



}
