namespace KTKGuest.Web.Repositories;

public class RefreshSessionsRepository : IRefreshSessionsRepository
{
    private readonly IConfiguration _configuration;
    private readonly string _connectionString;
    public RefreshSessionsRepository(IConfiguration configuration)
    {
        _configuration = configuration;
        _connectionString = _configuration.GetConnectionString("PostgreConnectionString") ?? throw new ArgumentException(nameof(_connectionString));
    }
    public async Task CreateRefreshSession(int id, RefreshToken refreshToken)
    {
        using var conn = new NpgsqlConnection(_connectionString);
        string query = "INSERT INTO refresh_sessions(user_id, refresh_token, created, expires) " +
                       "VALUES(@id, @refresh_token, @created, @expires); ";

        using var cmd = new NpgsqlCommand(query, conn);
        cmd.Parameters.AddWithValue("@id", id);
        cmd.Parameters.AddWithValue("@refresh_token", refreshToken.Token);
        cmd.Parameters.AddWithValue("@created", refreshToken.Created);
        cmd.Parameters.AddWithValue("@expires", refreshToken.Expires);

        conn.Open();
        int rows = await cmd.ExecuteNonQueryAsync();
    }

    public async Task DeleteRefreshSession(string refreshToken)
    {
        using var conn = new NpgsqlConnection(_connectionString);
        string query = "DELETE FROM refresh_sessions " +
                       "WHERE refresh_token = @refresh_token; ";

        using var cmd = new NpgsqlCommand(query, conn);
        cmd.Parameters.AddWithValue("@refresh_token", refreshToken);

        conn.Open();
        int rows = await cmd.ExecuteNonQueryAsync();
    }

    public async Task<RefreshToken> GetRefreshSession(string refreshToken)
    {
        var dt = new DataTable();
        var refeshTokenDto = new RefreshToken();

        using var conn = new NpgsqlConnection(_connectionString);
        string query = "SELECT refresh_token, expires FROM refresh_sessions " +
                       "WHERE refresh_token = @refresh_token; ";

        using (var cmd = new NpgsqlCommand(query, conn))
        {
            cmd.Parameters.AddWithValue("@refresh_token", refreshToken);

            conn.Open();
            NpgsqlDataReader dataReader = await cmd.ExecuteReaderAsync();
            dt.Load(dataReader);
        }

        if (dt.Rows.Count < 1)
            return null;


        foreach (DataRow row in dt.Rows)
        {
            refeshTokenDto.Token = (string)row["refresh_token"];
            refeshTokenDto.Expires = (DateTime)row["expires"];
        }

        return refeshTokenDto;
    }
}
