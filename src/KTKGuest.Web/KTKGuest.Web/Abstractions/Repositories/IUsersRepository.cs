namespace KTKGuest.Web.Abstractions.Repositories;

public interface IUsersRepository
{
    Task<int> CreateUserAsync(string login, string password, string role);
    Task<int> UpdateUserAsync(int id, string login, string password, string role);
    Task<int> DeleteUserAsync(int id);
    Task<List<UserDto>> GetAllUsersAsync();
    Task<UserDto> GetUserById(int id);
    Task<UserDto> GetUserDetailsAsync(string login);
    Task<UserDto> GetUserDetailsByRefreshTokenAsync(string refreshToken);
}