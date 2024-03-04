namespace KTKGuest.Web.Abstractions.Services;

public interface IUsersService
{
    Task<bool> CreateUserAsync(string login, string password, string role);
    Task<bool> UpdateUserAsync(int id, string login, string password, string role);
    Task<bool> DeleteUserAsync(int id);
    Task<List<UserDto>> GetAllUsersAsync();
    Task<UserDto> GetUserById(int id);
    Task<UserDto> GetUserDetailsAsync(string login);
    Task<UserDto> GetUserDetailsByRefreshTokenAsync(string refreshToken);
}
