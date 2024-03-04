namespace KTKGuest.Web.Abstractions.Services;

public interface IJWTService
{
    string GenerateAccessToken(UserDto user);
    RefreshToken GenerateRefreshToken();
    void UpdateRefreshJWT(RefreshToken refreshToken, UserDto user);
}
