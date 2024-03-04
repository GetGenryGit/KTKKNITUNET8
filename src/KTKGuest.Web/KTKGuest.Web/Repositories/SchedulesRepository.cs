namespace KTKGuest.Web.Repositories;

public class SchedulesRepository : ISchedulesRepository
{
    private readonly IConfiguration _configuration;
    private readonly string _connectionString;
    public SchedulesRepository(IConfiguration configuration)
    {
        _configuration = configuration;
        _connectionString = _configuration.GetConnectionString("PostgreConnectionString") ?? throw new ArgumentException(nameof(_connectionString));
    }
    public async Task<ScheduleItem> AddScheduleAsync(DateTime date, ScheduleGet data)
    {
        using var conn = new NpgsqlConnection(_connectionString);

        string query;

        query = "INSERT INTO schedules(study_date) " +
                "VALUES(@study_date); ";

        using (var cmd = new NpgsqlCommand(query, conn))
        {
            cmd.Parameters.AddWithValue("@study_date", date);
            conn.Open();
            int rows = await cmd.ExecuteNonQueryAsync();
        }

        query = "INSERT INTO schedules_details" +
                "(schedule_id, class_index, teacher_id, " +
                "subject_id, collective_id, classroom_id, sub_group) " +
                "VALUES" +
                "( " +
                "   (SELECT id FROM schedules WHERE study_date = @date), " +
                "   @class_index, " +
                "   (SELECT id FROM teachers WHERE title = @teacher), " +
                "   (SELECT id FROM subjects WHERE title = @subject), " +
                "   (SELECT id FROM collectives WHERE title = @collective), " +
                "   (SELECT id FROM classrooms WHERE title = @classroom), " +
                "   @sub_group " +
                "); ";

        for (int i = 0; i < data.ScheduleListData.Count; i++)
        {
            try
            {
                using var cmd = new NpgsqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@date", date);
                cmd.Parameters.AddWithValue("@class_index", data.ScheduleListData[i].ClassIndex);
                cmd.Parameters.AddWithValue("@teacher", data.ScheduleListData[i].Teacher);
                cmd.Parameters.AddWithValue("@subject", data.ScheduleListData[i].Subject);
                cmd.Parameters.AddWithValue("@collective", data.ScheduleListData[i].Collective);
                cmd.Parameters.AddWithValue("@classroom", data.ScheduleListData[i].Classroom);
                cmd.Parameters.AddWithValue("@sub_group", data.ScheduleListData[i].SubGroup);

                int rows = await cmd.ExecuteNonQueryAsync();
            }
            catch
            {
                // if Exception return error group
                return data.ScheduleListData[i];
            }
        }

        query = "INSERT INTO schedules_times(schedule_id, start_at, end_at) " +
                "VALUES " +
                "( " +
                "   (SELECT id FROM schedules WHERE study_date = @date)," +
                "   @start_at," +
                "   @end_at" +
                "); ";

        for (int i = 0; i < data.StartAt.Count; i++)
        {
            using var cmd = new NpgsqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@date", date);
            cmd.Parameters.AddWithValue("@start_at", data.StartAt[i]);
            cmd.Parameters.AddWithValue("@end_at", data.EndAt[i]);

            int rows = await cmd.ExecuteNonQueryAsync();
        }
        return null;
    }

    public async Task<int> DeleteScheduleAsync(DateTime date)
    {
        using var conn = new NpgsqlConnection(_connectionString);

        string query = "DELETE FROM schedules " +
                       "WHERE study_date = @date; ";

        using var cmd = new NpgsqlCommand(query, conn);
        cmd.Parameters.AddWithValue("@date", date);
        conn.Open();
        return await cmd.ExecuteNonQueryAsync();
    }

    public async Task<ScheduleGet> GetScheduleByClassroomAsync(DateTime date, string value)
    {
        var scheduleGet = new ScheduleGet();
        var dtTime = new DataTable();
        var dtSchedule = new DataTable();

        using (var conn = new NpgsqlConnection(_connectionString))
        {
            string query;

            query = "SELECT " +
                    "start_at, end_at " +
                    "FROM schedules_times " +
                    "WHERE schedule_id = (SELECT id FROM schedules WHERE study_date = @date); ";

            using (var cmd = new NpgsqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@date", date);

                conn.Open();
                NpgsqlDataReader dataReader = await cmd.ExecuteReaderAsync();
                dtTime.Load(dataReader);
            }

            foreach (DataRow row in dtTime.Rows)
            {
                scheduleGet.StartAt.Add((TimeSpan)row["start_at"]);
                scheduleGet.EndAt.Add((TimeSpan)row["end_at"]);
            }

            query = "SELECT " +
                    "class_index, " +
                    "(SELECT title FROM teachers WHERE id = teacher_id) AS teacher, " +
                    "(SELECT title FROM subjects WHERE id = subject_id) AS subject, " +
                    "(SELECT title FROM collectives WHERE id = collective_id) AS collective, " +
                    "(SELECT title FROM classrooms WHERE id = classroom_id) AS classroom, " +
                    "sub_group " +
                    "FROM schedules_details " +
                    "WHERE schedule_id = (SELECT id FROM schedules WHERE study_date = @date) AND classroom_id = (SELECT id FROM classrooms where title = @value); ";

            using (var cmd = new NpgsqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@date", date);
                cmd.Parameters.AddWithValue("@value", value);

                NpgsqlDataReader dataReader = await cmd.ExecuteReaderAsync();
                dtSchedule.Load(dataReader);
            }

            foreach (DataRow row in dtSchedule.Rows)
            {
                scheduleGet.ScheduleListData.Add(new ScheduleItem
                {
                    ClassIndex = (int)row["class_index"],
                    Teacher = (string)row["teacher"],
                    Subject = (string)row["subject"],
                    Collective = (string)row["collective"],
                    Classroom = (string)row["classroom"],
                    SubGroup = (int)row["sub_group"]
                });
            }
        }
        return scheduleGet;
    }

    public async Task<ScheduleGet> GetScheduleByCollectiveAsync(DateTime date, string value)
    {
        var scheduleGet = new ScheduleGet();
        var dtTime = new DataTable();
        var dtSchedule = new DataTable();

        using (var conn = new NpgsqlConnection(_connectionString))
        {
            string query;

            query = "SELECT " +
                    "start_at, end_at " +
                    "FROM schedules_times " +
                    "WHERE schedule_id = (SELECT id FROM schedules WHERE study_date = @date); ";

            using (var cmd = new NpgsqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@date", date);

                conn.Open();
                NpgsqlDataReader dataReader = await cmd.ExecuteReaderAsync();
                dtTime.Load(dataReader);
            }

            foreach (DataRow row in dtTime.Rows)
            {
                scheduleGet.StartAt.Add((TimeSpan)row["start_at"]);
                scheduleGet.EndAt.Add((TimeSpan)row["end_at"]);
            }

            query = "SELECT " +
                    "class_index, " +
                    "(SELECT title FROM teachers WHERE id = teacher_id) AS teacher, " +
                    "(SELECT title FROM subjects WHERE id = subject_id) AS subject, " +
                    "(SELECT title FROM collectives WHERE id = collective_id) AS collective, " +
                    "(SELECT title FROM classrooms WHERE id = classroom_id) AS classroom, " +
                    "sub_group " +
                    "FROM schedules_details " +
                    "WHERE schedule_id = (SELECT id FROM schedules WHERE study_date = @date) AND collective_id = (SELECT id FROM collectives where title = @value);";

            using (var cmd = new NpgsqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@date", date);
                cmd.Parameters.AddWithValue("@value", value);

                NpgsqlDataReader dataReader = await cmd.ExecuteReaderAsync();
                dtSchedule.Load(dataReader);
            }

            foreach (DataRow row in dtSchedule.Rows)
            {
                scheduleGet.ScheduleListData.Add(new ScheduleItem
                {
                    ClassIndex = (int)row["class_index"],
                    Teacher = (string)row["teacher"],
                    Subject = (string)row["subject"],
                    Collective = (string)row["collective"],
                    Classroom = (string)row["classroom"],
                    SubGroup = (int)row["sub_group"]
                });
            }
        }
        return scheduleGet;
    }

    public async Task<ScheduleGet> GetScheduleByTeacherAsync(DateTime date, string value)
    {
        var scheduleGet = new ScheduleGet();
        var dtTime = new DataTable();
        var dtSchedule = new DataTable();

        using (var conn = new NpgsqlConnection(_connectionString))
        {
            string query;

            query = "SELECT " +
                    "start_at, end_at " +
                    "FROM schedules_times " +
                    "WHERE schedule_id = (SELECT id FROM schedules WHERE study_date = @date); ";

            using (var cmd = new NpgsqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@date", date);

                conn.Open();
                NpgsqlDataReader dataReader = cmd.ExecuteReader();
                dtTime.Load(dataReader);
            }

            foreach (DataRow row in dtTime.Rows)
            {
                scheduleGet.StartAt.Add((TimeSpan)row["start_at"]);
                scheduleGet.EndAt.Add((TimeSpan)row["end_at"]);
            }

            query = "SELECT " +
                    "class_index, " +
                    "(SELECT title FROM teachers WHERE id = teacher_id) AS teacher, " +
                    "(SELECT title FROM subjects WHERE id = subject_id) AS subject, " +
                    "(SELECT title FROM collectives WHERE id = collective_id) AS collective, " +
                    "(SELECT title FROM classrooms WHERE id = classroom_id) AS classroom, " +
                    "sub_group " +
                    "FROM schedules_details " +
                    "WHERE schedule_id = (SELECT id FROM schedules WHERE study_date = @date) AND teacher_id = (SELECT id FROM teachers where title = @value);";


            using (var cmd = new NpgsqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@date", date);
                cmd.Parameters.AddWithValue("@value", value);

                NpgsqlDataReader dataReader = await cmd.ExecuteReaderAsync();
                dtSchedule.Load(dataReader);
            }

            foreach (DataRow row in dtSchedule.Rows)
            {
                scheduleGet.ScheduleListData.Add(new ScheduleItem
                {
                    ClassIndex = (int)row["class_index"],
                    Teacher = (string)row["teacher"],
                    Subject = (string)row["subject"],
                    Collective = (string)row["collective"],
                    Classroom = (string)row["classroom"],
                    SubGroup = (int)row["sub_group"]
                });
            }
        }
        return scheduleGet;
    }

    public async Task<ScheduleGet> GetScheduleAsync(DateTime date)
    {
        var scheduleGet = new ScheduleGet();
        var dtTime = new DataTable();
        var dtSchedule = new DataTable();

        using (var conn = new NpgsqlConnection(_connectionString))
        {
            string query;

            query = "SELECT " +
                    "start_at, end_at " +
                    "FROM schedules_times " +
                    "WHERE schedule_id = (SELECT id FROM schedules WHERE study_date = @date); ";

            using (var cmd = new NpgsqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@date", date);

                conn.Open();
                NpgsqlDataReader dataReader = await cmd.ExecuteReaderAsync();
                dtTime.Load(dataReader);
            }

            foreach (DataRow row in dtTime.Rows)
            {
                scheduleGet.StartAt.Add((TimeSpan)row["start_at"]);
                scheduleGet.EndAt.Add((TimeSpan)row["end_at"]);
            }

            query = "SELECT " +
                    "class_index, " +
                    "(SELECT title FROM teachers WHERE id = teacher_id) AS teacher, " +
                    "(SELECT title FROM subjects WHERE id = subject_id) AS subject, " +
                    "(SELECT title FROM collectives WHERE id = collective_id) AS collective, " +
                    "(SELECT title FROM classrooms WHERE id = classroom_id) AS classroom, " +
                    "sub_group " +
                    "FROM schedules_details " +
                    "WHERE schedule_id = (SELECT id FROM schedules WHERE study_date = @date)";

            using (var cmd = new NpgsqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@date", date);

                NpgsqlDataReader dataReader = await cmd.ExecuteReaderAsync();
                dtSchedule.Load(dataReader);
            }

            foreach (DataRow row in dtSchedule.Rows)
            {
                scheduleGet.ScheduleListData.Add(new ScheduleItem
                {
                    ClassIndex = (int)row["class_index"],
                    Teacher = (string)row["teacher"],
                    Subject = (string)row["subject"],
                    Collective = (string)row["collective"],
                    Classroom = (string)row["classroom"],
                    SubGroup = (int)row["sub_group"]
                });
            }
        }
        return scheduleGet;
    }
}
