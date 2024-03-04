namespace KTKGuest.Web.Abstractions.Repositories;

public interface IFeedbacksRepository
{
    Task<List<FeedbackContent>> GetFeedbacksByStatusAsync(FeedbackStatus type);
    Task<int> AddFeedbackAsync(string name, string email, string content);
    Task<int> ChangeStatus(int id, FeedbackStatus status);
}
