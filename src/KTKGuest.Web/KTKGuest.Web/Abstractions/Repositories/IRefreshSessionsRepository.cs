namespace KTKGuest.Web.Abstractions.Repositories;

public interface IRefreshSessionsRepository
{
    Task CreateRefreshSession(int id, RefreshToken refreshToken);
    Task DeleteRefreshSession(string refreshToken);
    Task<RefreshToken> GetRefreshSession(string refreshToken);
}
