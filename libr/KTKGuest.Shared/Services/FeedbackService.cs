using KTKGuest.Shared.Abstractions.Services;

namespace KTKGuest.Shared.Services;

public class FeedbackService : IFeedbackService
{
    private readonly IHttpService _httpService;
    public FeedbackService(IHttpService httpService)
    {
        _httpService = httpService;
    }

    public async Task<APIResponse> SendAsync(FeedbackContent model)
        => await _httpService.Post(APIConstants.SendFeedback, model);
}
