
namespace KTKGuest.Web.Services;

public class UsersService : IUsersService
{
    private readonly IUsersRepository _usersRepository;
    public UsersService(IUsersRepository usersRepository)
    {
        _usersRepository = usersRepository;
    }
    public async Task<bool> CreateUserAsync(string login, string password, string role)
    {
        int rows = await _usersRepository.CreateUserAsync(login, password, role);
        return rows > 0;
    }


    public async Task<bool> DeleteUserAsync(int id)
    {
        int rows = await _usersRepository.DeleteUserAsync(id);
        return rows > 0;
    }

    public Task<List<UserDto>> GetAllUsersAsync()
        => _usersRepository.GetAllUsersAsync();

    public async Task<bool> UpdateUserAsync(int id, string login, string password, string role)
    {
        int rows = await _usersRepository.UpdateUserAsync(id, login, password, role);
        return rows > 0;
    }

    public Task<UserDto> GetUserById(int id)
        => _usersRepository.GetUserById(id);

    public Task<UserDto> GetUserDetailsAsync(string login)
        => _usersRepository.GetUserDetailsAsync(login);

    public Task<UserDto> GetUserDetailsByRefreshTokenAsync(string refreshToken)
        => _usersRepository.GetUserDetailsByRefreshTokenAsync(refreshToken);

}
