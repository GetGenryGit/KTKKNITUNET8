namespace KTKGuest.Web.Controllers;

[Route("api/[controller]")]
[ApiController]
public class FeedbacksController(IFeedbacksRepository feedbackRepository) : ControllerBase
{
    private readonly IFeedbacksRepository _feedbackRepository = feedbackRepository;

    [Authorize(Roles = "А.П.")]
    [HttpGet("get")]
    public async Task<IActionResult> Get(FeedbackStatus status) 
    {
        var response = new APIResponse();

        try
        {
            var list = await _feedbackRepository.GetFeedbacksByStatusAsync(status);

            response.Result = true;
            response.Message = "Формы обратной связи успешно получены!";
            response.Obj = list;

            return Ok(response);
        }
        catch (Exception ex) 
        {
#if DEBUG
            response.Message = ex.Message;
#else
            response.Message = "Произошла ошибка на стороне сервера, при получение форм обратной связи!";
#endif
            return BadRequest(response);
        }
    }

    [HttpPost("add")]
    public async Task<IActionResult> Add([FromBody] FeedbackContent model)
    {
        var response = new APIResponse();

        try
        {
            ArgumentException.ThrowIfNullOrWhiteSpace(model.Name);
            ArgumentException.ThrowIfNullOrWhiteSpace(model.Email);
            ArgumentException.ThrowIfNullOrWhiteSpace(model.Content);

            var rows = await _feedbackRepository.AddFeedbackAsync(model.Name, model.Email, model.Content);
            if (rows < 1)
            {
                response.Result = false;
                response.Message = "Произошла ошибка при отправке заявки!";

                return Ok(response);
            }

            response.Result = true;
            response.Message = "Ваша заявка успешно отправлена!";
            response.Obj = model;

            return Ok(response);
        }
        catch (Exception ex) 
        {
#if DEBUG
            response.Message = ex.Message;
#else
            response.Message = "Произошла ошибка на стороне сервера, при отправке формы обратной связи!";
#endif
            return BadRequest(response);
        }
    }

    [Authorize(Roles = "А.П.")]
    [HttpPut("change_status/{id}")]
    public async Task<IActionResult> ChangeStatus([FromRoute] int id, [FromBody] FeedbackStatus status)
    {
        var response = new APIResponse();

        try
        {
            var rows = await _feedbackRepository.ChangeStatus(id, status);
            if (rows < 1)
            {
                response.Result = false;
                response.Message = "Произошла ошибка при смене статуса формы обратной связи!";

                return Ok(response);
            }

            response.Result = true;
            response.Message = "Статус обратной связи успешно изменен!";
            response.Obj = status;

            return Ok(response);
        }
        catch (Exception ex)
        {
#if DEBUG
            response.Message = ex.Message;
#else
            response.Message = "Произошла ошибка на стороне сервера, при отправке формы обратной связи!";
#endif
            return BadRequest(response);
        }
    }

}
