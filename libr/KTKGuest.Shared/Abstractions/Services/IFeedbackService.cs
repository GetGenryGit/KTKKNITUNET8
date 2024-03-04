namespace KTKGuest.Shared.Abstractions.Services;

public interface IFeedbackService
{
    Task<APIResponse> SendAsync(FeedbackContent model);
}