namespace KTKGuest.Web.Repositories;

public class FeedBacksRepository : IFeedbacksRepository
{
    private readonly IConfiguration _configuration;
    private readonly string _connectionString;
    public FeedBacksRepository(IConfiguration configuration)
    {
        _configuration = configuration;
        _connectionString = _configuration.GetConnectionString("PostgreConnectionString") ?? throw new ArgumentException(nameof(_connectionString));
    }
    public async Task<int> AddFeedbackAsync(string name, string email, string content)
    {
        using var conn = new NpgsqlConnection(_connectionString);
        string query = "INSERT INTO feedbacks(name, email, content, status_id)" +
                       "VALUES(@name, @email, @content, (SELECT id FROM feedbacks_statuses WHERE title = 'New'))";

        using var cmd = new NpgsqlCommand(query, conn);
        cmd.Parameters.AddWithValue("@name", name);
        cmd.Parameters.AddWithValue("@email", email);
        cmd.Parameters.AddWithValue("@content", content);

        await conn.OpenAsync();
        return await cmd.ExecuteNonQueryAsync();
    }

    public async Task<int> ChangeStatus(int id, FeedbackStatus status)
    {
        using var conn = new NpgsqlConnection(_connectionString);
        string query = "UPDATE feedbacks " +
                       "SET status_id = (SELECT id FROM feedbacks_statuses WHERE title = @status) " +
                       "WHERE id = @id; ";

        using var cmd = new NpgsqlCommand(query, conn);
        cmd.Parameters.AddWithValue("@id", id);
        cmd.Parameters.AddWithValue("@status", status.ToString());

        await conn.OpenAsync();
        return await cmd.ExecuteNonQueryAsync();
    }

    public async Task<List<FeedbackContent>> GetFeedbacksByStatusAsync(FeedbackStatus status)
    {
        var list = new List<FeedbackContent>();
        var dt = new DataTable();

        using var conn = new NpgsqlConnection(_connectionString);
        string query = "SELECT id, name, email, content " +
                       "FROM feedbacks " +
                       "WHERE status_id = (SELECT id FROM feedbacks_statuses WHERE title = @status) " +
                       "ORDER BY id; ";

        using (var cmd = new NpgsqlCommand(query, conn))
        {
            cmd.Parameters.AddWithValue("@status", status.ToString());

            await conn.OpenAsync();

            NpgsqlDataReader dataReader = await cmd.ExecuteReaderAsync();
            dt.Load(dataReader);
        }

        if (dt.Rows.Count < 1)
            return list;

        foreach (DataRow user in dt.Rows)
        {
            list.Add(new FeedbackContent
            {
                Id = (int)user["id"],
                Name = (string)user["name"],
                Email = (string)user["email"],
                Content = (string)user["content"]
            });
        }

        return list;
    }
}
