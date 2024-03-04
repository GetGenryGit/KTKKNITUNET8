namespace KTKGuest.Web.Repositories;

public class LogsRepository : ILogsRepository
{
    private readonly IConfiguration _configuration;
    private readonly string _connectionString;
    public LogsRepository(IConfiguration configuration)
    {
        _configuration = configuration;
        _connectionString = _configuration.GetConnectionString("PostgreConnectionString") ?? throw new ArgumentException(nameof(_connectionString));
    }

    public async Task<List<HistoryItem>> GetLogs(string role)
    {
        var dt = new DataTable();
        var list = new List<HistoryItem>();

        using (var conn = new NpgsqlConnection(_connectionString))
        {
            string queries;

            queries = "SELECT event_describe, date_created " +
                      "FROM logs " +
                      "WHERE role_id = (SELECT id FROM roles WHERE title = @role)" +
                      "ORDER BY date_created DESC;";

            using (var cmd = new NpgsqlCommand(queries, conn))
            {
                cmd.Parameters.AddWithValue("@role", role);

                await conn.OpenAsync();
                NpgsqlDataReader dataReader = await cmd.ExecuteReaderAsync();
                dt.Load(dataReader);
            }

            foreach (DataRow row in dt.Rows)
            {
                list.Add(new HistoryItem
                {
                    EventDescribe = (string)row["event_describe"],
                    DateCreated = (DateTime)row["date_created"]
                });
            }
        }

        return list;
    }
    public async Task<int> SaveLog(string message, string role)
    {
        using var conn = new NpgsqlConnection(_connectionString);

        string query = "INSERT INTO logs(event_describe, role_id) " +
                       "VALUES(@message, " +
                       "(SELECT id FROM roles WHERE title = @role)); ";

        using var cmd = new NpgsqlCommand(query, conn);
        cmd.Parameters.AddWithValue("@message", message);
        cmd.Parameters.AddWithValue("@role", role);
        await conn.OpenAsync();
        return await cmd.ExecuteNonQueryAsync();
    }
}
