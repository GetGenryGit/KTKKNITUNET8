namespace KTKGuest.Web.Abstractions.Services;

public interface IAuthService
{
    Task<Tokens> SignIn(string login, string password);
    Task SignOut(string refreshToken);
    Task<Tokens> RefreshToken(string refreshToken);
}
