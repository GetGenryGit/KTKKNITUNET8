using System.Reflection;

namespace KTKGuest.Web.Controllers;

[Route("api/[controller]")]
[ApiController]
public class AuthController(IAuthService authService,
    ILogsService logsService) : ControllerBase
{
    private readonly IAuthService _authService = authService;
    private readonly ILogsService _logsService = logsService;

    [HttpPost("sign_in")]
    public async Task<IActionResult> SignIn([FromBody] LoginUser model)
    {
        var response = new APIResponse();

        try
        {
            var tokens = await _authService.SignIn(model.Login, model.Password);
            if (tokens == null)
            {
                response.Message = "Неправильный логин или пароль!";
                return Ok(response);
            }

            response.Result = true;
            response.Message = "Пользователь успешно прошел аутенфикацию!";
            response.Obj = tokens;

            var isSuccessLoged = await _logsService.SaveLog($"Пользователь с логином {model.Login} успешно прошел аунтификацию!", "А.П.");

            return Ok(response);
        }
        catch (Exception ex)
        {
            var isSuccessLoged = await _logsService.SaveLog($"Произошла ошибка при аунтификации пользователся с логином {model.Login}!", "А.П.");

#if DEBUG
            response.Message = ex.Message;
#else
            response.Message = "Произошла ошибка на стороне сервера!";
#endif

            return BadRequest(ex.Message);
        }        
    }

    [HttpPost("sign_out")]
    public async Task<IActionResult> SignOut([FromBody] TokenRequest token)
    {
        var response = new APIResponse();

        try
        {
            await _authService.SignOut(token.Token);

            response.Result = true;
            response.Message = "Пользователь успешно вышел из системы!";

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

    [HttpPut("refresh_token")]
    public async Task<IActionResult> RefreshToken([FromBody] TokenRequest token)
    {
        var response = new APIResponse();

        if (string.IsNullOrWhiteSpace(token.Token))
            return Unauthorized();

        try
        {
            var tokens = await _authService.RefreshToken(token.Token);
            if (tokens == null)
            {
                response.Message = "Необходимо пройти аунтификацию!";
                return Unauthorized(response);
            }

            response.Result = true;
            response.Message = "Оба токена успешно обновлены!";
            response.Obj = tokens;

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
