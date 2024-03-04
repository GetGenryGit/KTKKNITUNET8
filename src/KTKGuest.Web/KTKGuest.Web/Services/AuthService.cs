namespace KTKGuest.Web.Services;

public class AuthService : IAuthService
{
    private readonly IUsersRepository _userRepository;
    private readonly IRefreshSessionsRepository _refreshSessionRepository;
    private readonly IJWTService _jwtService;
    public AuthService(IUsersRepository userRepository, 
        IRefreshSessionsRepository refreshSessionRepository,
        IJWTService jwtService)
    {
        _userRepository = userRepository;
        _refreshSessionRepository = refreshSessionRepository;
        _jwtService = jwtService;
    }

    public async Task<Tokens> RefreshToken(string refreshToken)
    {
        if (string.IsNullOrWhiteSpace(refreshToken))
            return null;

        var refreshTokenDto = await _refreshSessionRepository.GetRefreshSession(refreshToken);
        if (refreshTokenDto == null)
            return null;

        if (refreshTokenDto.Expires < DateTime.Now)
        {
            await _refreshSessionRepository.DeleteRefreshSession(refreshToken);
            return null;
        }

        var userDto = await _userRepository.GetUserDetailsByRefreshTokenAsync(refreshToken);
        var userDetails = new UserDetails { Login = userDto.Login, Role = userDto.Role };
        await _refreshSessionRepository.DeleteRefreshSession(refreshToken);

        var newAccessToken = _jwtService.GenerateAccessToken(userDto);
        var newRefreshToken =_jwtService.GenerateRefreshToken();

        await _refreshSessionRepository.CreateRefreshSession(userDto.Id, newRefreshToken);

        return new Tokens { AccessToken = newAccessToken, RefreshToken = newRefreshToken.Token };
    }

    public async Task<Tokens> SignIn(string login, string password)
    {
        var userDto = await _userRepository.GetUserDetailsAsync(login);
        if (userDto == null)
            return null;

        var isPasswordValid = HashPasswordHelper.HashPassword(password) == userDto.Password;
        if (!isPasswordValid)
            return null;
        
        var userDetails = new UserDetails { Login = userDto.Login, Role = userDto.Role };

        var accessToken = _jwtService.GenerateAccessToken(userDto);
        var refreshToken = _jwtService.GenerateRefreshToken();

        await _refreshSessionRepository.CreateRefreshSession(userDto.Id, refreshToken);

        return new Tokens { AccessToken = accessToken, RefreshToken = refreshToken.Token };
    }

    public async Task SignOut(string refreshToken)
        => await _refreshSessionRepository.DeleteRefreshSession(refreshToken);

}
