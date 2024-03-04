namespace KTKGuest.Web.Repositories;

public class ClassroomsRepository : IClassroomsRepository
{
    private readonly IConfiguration _configuration;
    private readonly string _connectionString;
    public ClassroomsRepository(IConfiguration configuration)
    {
        _configuration = configuration;
        _connectionString = _configuration.GetConnectionString("PostgreConnectionString") ?? throw new ArgumentException(nameof(_connectionString));
    }
    public async Task<int> AddClassroomsAsync(List<string> list)
    {
        int rows = 0;

        using var conn = new NpgsqlConnection(_connectionString);
        string query;

        query = "UPDATE classrooms " +
                "SET status = '0'; ";

        using (var cmd = new NpgsqlCommand(query, conn))
        {
            conn.Open();
            int disabledRows = await cmd.ExecuteNonQueryAsync();
        }

        query = "INSERT INTO classrooms(title) " +
                "VALUES(@item) " +
                "ON CONFLICT(title) DO " +
                "UPDATE " +
                "SET status = '1'; ";

        foreach (var item in list)
        {
            using var cmd = new NpgsqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@item", item);
            rows += await cmd.ExecuteNonQueryAsync();
        }

        return rows;
    }
    public async Task<List<string>> GetActiveClassroomsAsync()
    {
        var dt = new DataTable();   
        var list = new List<string>();

        using (var conn = new NpgsqlConnection(_connectionString))
        {
            conn.Open();

            string query = "SELECT " +
                           "title " +
                           "FROM classrooms " +
                           "WHERE status = '1' " +
                           "ORDER BY title ASC; ";

            using (var cmd = new NpgsqlCommand(query, conn))
            {
                NpgsqlDataReader dataReader = await cmd.ExecuteReaderAsync();
                dt.Load(dataReader);
            }

            foreach (DataRow row in dt.Rows)
            {
                list.Add((string)row["title"]);
            }
        }

        return list;
    }
    public async Task<List<DictionaryItem>> GetAllClassroomsAsync()
    {
        var dt = new DataTable();
        var list = new List<DictionaryItem>();

        using (var conn = new NpgsqlConnection(_connectionString))
        {
            conn.Open();

            string query = "SELECT id, title, status " +
                           "FROM classrooms " +
                           "ORDER BY id ASC; ";

            using (var cmd = new NpgsqlCommand(query, conn))
            {
                NpgsqlDataReader dataReader = await cmd.ExecuteReaderAsync();
                dt.Load(dataReader);
            }

            foreach (DataRow row in dt.Rows)
            {
                list.Add(new DictionaryItem
                {
                    Id = (int)row["id"],
                    Title = (string)row["title"],
                    Status = (bool)row["status"]
                });
            }
        }
        return list;
    }
}
