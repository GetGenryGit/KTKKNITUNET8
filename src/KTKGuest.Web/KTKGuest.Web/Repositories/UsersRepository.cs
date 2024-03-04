namespace KTKGuest.Web.Repositories;

public class UsersRepository : IUsersRepository
{
    private readonly IConfiguration _configuration;
    private readonly string _connectionString;
    public UsersRepository(IConfiguration configuration)
    {
        _configuration = configuration;
        _connectionString = _configuration.GetConnectionString("PostgreConnectionString") ?? throw new ArgumentException(nameof(_connectionString));
    }

    public async Task<int> CreateUserAsync(string login, string password, string role)
    {
        using var conn = new NpgsqlConnection(_connectionString);

        string query = "INSERT INTO users (login, pass, role_id) " +
                       "VALUES(@login, @pass, (SELECT id FROM roles WHERE title = @role_title)); ";

        using var cmd = new NpgsqlCommand(query, conn);
        cmd.Parameters.AddWithValue("@login", login);
        cmd.Parameters.AddWithValue("@pass", HashPasswordHelper.HashPassword(password));
        cmd.Parameters.AddWithValue("@role_title", role);

        await conn.OpenAsync();
        return await cmd.ExecuteNonQueryAsync();
    }
    public async Task<int> DeleteUserAsync(int id)
    {
        using var conn = new NpgsqlConnection(_connectionString);
        string query = "DELETE FROM users WHERE id = @id";

        using var cmd = new NpgsqlCommand(query, conn);
        cmd.Parameters.AddWithValue("@id", id);

        conn.Open();
        return await cmd.ExecuteNonQueryAsync();
    }
    public async Task<int> UpdateUserAsync(int id, string login, string password, string role)
    {
        using var conn = new NpgsqlConnection(_connectionString);
        string query;

        if (string.IsNullOrWhiteSpace(password) || password == "EmptyField")
        {
            query = "UPDATE users " +
                    "SET login = @login, role_id = (SELECT id FROM roles WHERE title = @role_title) " +
                    "WHERE id = @id; ";
           
        }
        else
        {
            query = "UPDATE users " +
                    "SET login = @login, pass = @pass, role_id = (SELECT id FROM roles WHERE title = @role_title) " +
                    "WHERE id = @id; ";
        }

        using var cmd = new NpgsqlCommand(query, conn);
        cmd.Parameters.AddWithValue("@id", id);
        cmd.Parameters.AddWithValue("@login", login);
        cmd.Parameters.AddWithValue("@pass", HashPasswordHelper.HashPassword(password));
        cmd.Parameters.AddWithValue("@role_title", role);

        conn.Open();
        return await cmd.ExecuteNonQueryAsync();
    }
    public async Task<List<UserDto>> GetAllUsersAsync()
    {
        var dt = new DataTable();
        var list = new List<UserDto>();

        using var conn = new NpgsqlConnection(_connectionString);
        string query = "SELECT id, login, pass, " +
                       "(SELECT title FROM roles WHERE id = role_id) as role " +
                       "FROM users " +
                       "ORDER BY id";

        using (var cmd = new NpgsqlCommand(query, conn))
        {
            conn.Open();

            NpgsqlDataReader dataReader = await cmd.ExecuteReaderAsync();
            dt.Load(dataReader);
        }

        if (dt.Rows.Count < 1)
            return list;

        foreach (DataRow user in dt.Rows)
        {
            list.Add(new UserDto
            {
                Id = (int)user["id"],
                Login = (string)user["login"],
                Password = string.Empty,
                Role = (string)user["role"]
            });
        }

        return list;
    }
    public async Task<UserDto> GetUserById(int id)
    {
        var dt = new DataTable();
        UserDto? userDto = null;

        using var conn = new NpgsqlConnection(_connectionString);
        string query = "SELECT id, login, " +
                       "(SELECT title FROM roles WHERE id = role_id) as role " +
                       "FROM users " +
                       "WHERE id = @id; ";

        using (var cmd = new NpgsqlCommand(query, conn))
        {
            cmd.Parameters.AddWithValue("@id", id);

            conn.Open();

            NpgsqlDataReader dataReader = await cmd.ExecuteReaderAsync();
            dt.Load(dataReader);
        }

        if (dt.Rows.Count < 1)
            return null;

        foreach (DataRow user in dt.Rows)
        {
            userDto = new()
            {
                Id = (int)user["id"],
                Login = (string)user["login"],
                Role = (string)user["role"]
            };
        }

        return userDto;
    }
    public async Task<UserDto> GetUserDetailsAsync(string login)
    {
        var dt = new DataTable();
        UserDto? userDto = null;

        using var conn = new NpgsqlConnection(_connectionString);
        string query = "SELECT id, login, pass, " +
                       "(SELECT title FROM roles WHERE id = role_id) as role " +
                       "FROM users " +
                       "WHERE login = @login; ";

        using (var cmd = new NpgsqlCommand(query, conn))
        {
            cmd.Parameters.AddWithValue("@login", login);

            conn.Open();

            NpgsqlDataReader dataReader = await cmd.ExecuteReaderAsync();
            dt.Load(dataReader);
        }

        if (dt.Rows.Count < 1)
            return null;

        foreach (DataRow user in dt.Rows)
        {
            userDto = new()
            {
                Id = (int)user["id"],
                Login = (string)user["login"],
                Password = (string)user["pass"],
                Role = (string)user["role"]
            };
        }

        return userDto;
    }
    public async Task<UserDto> GetUserDetailsByRefreshTokenAsync(string refreshToken)
    {
        var dt = new DataTable();
        var userDto = new UserDto();

        using var conn = new NpgsqlConnection(_connectionString);
        string query = "SELECT id, login, pass, " +
                       "(SELECT title FROM roles WHERE id = role_id) as role " +
                       "FROM users " +
                       "WHERE id = (SELECT user_id FROM refresh_sessions WHERE refresh_token = @refresh_token); ";

        using (var cmd = new NpgsqlCommand(query, conn))
        {
            cmd.Parameters.AddWithValue("@refresh_token", refreshToken);

            conn.Open();

            NpgsqlDataReader dataReader = await cmd.ExecuteReaderAsync();
            dt.Load(dataReader);
        }

        if (dt.Rows.Count < 1)
            return null;

        foreach (DataRow user in dt.Rows)
        {
            userDto = new()
            {
                Id = (int)user["id"],
                Login = (string)user["login"],
                Password = (string)user["pass"],
                Role = (string)user["role"]
            };
        }

        return userDto;
    }
}
