namespace KTKGuest.Web.Controllers;

[Authorize]
[Route("api/[controller]")]
[ApiController]
public class UsersController(IUsersService userService,
    ILogsService logsService) : ControllerBase
{
    private readonly IUsersService _userService = userService;
    private readonly ILogsService _logsService = logsService;

    [Authorize(Roles = "А.П.")]
    [HttpPost("create")]
    public async Task<IActionResult> Create([FromBody] UserDto model)
    {
        var response = new APIResponse();

        try
        {
            ArgumentException.ThrowIfNullOrWhiteSpace(model.Login);
            ArgumentException.ThrowIfNullOrWhiteSpace(model.Password);
            ArgumentException.ThrowIfNullOrWhiteSpace(model.Role);

            var user = await _userService.GetUserDetailsAsync(model.Login);
            if (user != null)
            {
                response.Message = "Данный логин уже существует!";
                return Ok(response);
            }

            var isSuccessCreated = await _userService.CreateUserAsync(model.Login, model.Password, model.Role);
            if (!isSuccessCreated)
            {
                response.Message = "При добавление пользователя произошла ошибка!";
                response.Obj = model;

                return Ok(response);
            }

            response.Result = true;
            response.Message = "Пользователь успешно создан!";
            response.Obj = model;

            var isSuccessLoged = await _logsService.SaveLog($"Пользователь с логином {model.Login} успешно создан!", "А.П.");

            return Ok(response);
        }
        catch (Exception ex) 
        {
            var isSuccessLoged = await _logsService.SaveLog($"При создание пользователя с логином {model.Login}, произошла ошибка!", "А.П.");

#if DEBUG
            response.Message = ex.Message;
#else
            response.Message = "Произошла ошибка на стороне сервера!";
#endif

            return BadRequest(ex.Message);
        }
    }

    [Authorize(Roles = "А.П.")]
    [HttpDelete("delete/{id}")]
    public async Task<IActionResult> Delete([FromRoute] int id)
    {
        var response = new APIResponse();

        try
        {
            var isSuccessDeleted = await _userService.DeleteUserAsync(id);
            if (!isSuccessDeleted)
            {
                response.Message = $"Произошла ошибка при попытке удалить пользователя с номером {id}!";
                response.Obj = id;

                return Ok(response);
            }

            response.Result = true;
            response.Message = "Пользователь успешно удален!";
            response.Obj = id;

            var isSuccessLoged = await _logsService.SaveLog($"Пользователь под номером {id} успешно удалён!", "А.П.");

            return Ok(response);
        }
        catch (Exception ex)
        {
            var isSuccessLoged = await _logsService.SaveLog($"Произошла ошибка при удаление пользователя под номером {id}!", "А.П.");

#if DEBUG
            response.Message = ex.Message;
#else
            response.Message = "Произошла ошибка на стороне сервера!";
#endif
            return BadRequest(ex.Message);
        }
    }

    [Authorize(Roles = "А.П.")]
    [HttpGet("get_all")]
    public async Task<IActionResult> GetAll()
    {
        var response = new APIResponse();

        try
        {
            var list = await _userService.GetAllUsersAsync();

            response.Result = true;
            response.Message = "Список с пользоателями успешно получен!";
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

    [Authorize(Roles = "А.П.")]
    [HttpGet("get/{id}")]
    public async Task<IActionResult> Get([FromRoute] int id)
    {
        var response = new APIResponse();

        try
        {
            var user = await _userService.GetUserById(id);
            if (user == null)
            {
                response.Message = "Пользователь не найден!";

                return Ok(response);
            }
            response.Result = true;
            response.Message = "Пользоатель успешно получен!";
            response.Obj = user;

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

    [Authorize(Roles = "А.П.")]
    [HttpPut("update")]
    public async Task<IActionResult> Update([FromBody] UserDto model)
    {
        var response = new APIResponse();

        try
        {
            ArgumentException.Equals(model.Id, 0);
            ArgumentException.ThrowIfNullOrWhiteSpace(model.Login);
            ArgumentException.ThrowIfNullOrWhiteSpace(model.Password);
            ArgumentException.ThrowIfNullOrWhiteSpace(model.Role);

            var isSuccessUpdated = await _userService.UpdateUserAsync(model.Id, model.Login, model.Password, model.Role);
            if (!isSuccessUpdated)
            {
                response.Message = $"Произошла ошибка при попытке изменить пользователя под номером {model.Id}!";
            }

            response.Result = true;
            response.Message = $"Пользователь под идентифкационным номером {model.Id} успешно обновлeн!";
            response.Obj = model;

            var isSuccessLoged = await _logsService.SaveLog($"Пользователь под номером {model.Id} успешно изменён!", "А.П.");

            return Ok(response);
        }
        catch (Exception ex)
        {
            var isSuccessLoged = await _logsService.SaveLog($"Произошла ошибка при изменение пользователя под номером {model.Id}!", "А.П.");

#if DEBUG
            response.Message = ex.Message;
#else
            response.Message = "Произошла ошибка на стороне сервера!";
#endif
            return BadRequest(ex.Message);
        }

    }
}
