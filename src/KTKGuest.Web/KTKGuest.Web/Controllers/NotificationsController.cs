namespace KTKGuest.Web.Controllers;

[Route("api/[controller]")]
[ApiController]
public class NotificationsController : ControllerBase
{
    private readonly INotificationsService _notificationService;
    public NotificationsController(INotificationsService notificationService)
    {
        _notificationService = notificationService;
    }

    [Authorize(Roles = "О.Р., А.П.")]
    [HttpPost("send")]
    public async Task<IActionResult> Send([FromBody] NotificationContent model)
    {
        var response = new APIResponse();

        try
        {
            var resultSending = await _notificationService.SendAll(model.Title, model.Body);
            if (resultSending == null)
            {
                response.Message = "Ошибка при отправке уведомления!";
                response.Obj = resultSending;

                return Ok(response);
            }

            response.Result = true;
            response.Message = "Уведомление успешно отправлено!";
            response.Obj = resultSending;

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
