using System.Collections.Generic;

namespace KTKGuest.Web.Repositories;

public class TeacherActivityRepository : ITeacherActivityRepository
{
    private readonly IConfiguration _configuration;
    private readonly string _connectionString;
    public TeacherActivityRepository(IConfiguration configuration)
    {
        _configuration = configuration;
        _connectionString = _configuration.GetConnectionString("PostgreConnectionString") ?? throw new ArgumentException(nameof(_connectionString));
    }
    public async Task<int> AddByDate(DateTime date, string teacher, List<ScheduleItem> lessons)
    {
        int rows = 0;

        using var conn = new NpgsqlConnection(_connectionString);
        string query;

        query = "DELETE FROM teachers_activity " +
                "WHERE " +
                "schedule_id = (SELECT id FROM schedules WHERE study_date = @study_date) and " +
                "teacher_id = (SELECT id FROM teachers WHERE title = @teacher);";

        using (var cmd = new NpgsqlCommand(query, conn))
        {
            conn.Open();

            cmd.Parameters.AddWithValue("@study_date", date);
            cmd.Parameters.AddWithValue("@teacher", teacher);

            int DeletedRows = await cmd.ExecuteNonQueryAsync();
        }

        query = "INSERT INTO teachers_activity(schedule_id, class_index, teacher_id, " +
            "subject_id, collective_id, classroom_id, sub_group) " +
                "VALUES" +
                "(" +
                "   (SELECT id FROM schedules WHERE study_date = @study_date), " +
                "   @class_index," +
                "   (SELECT id FROM teachers WHERE title = @teacher), " +
                "   (SELECT id FROM subjects WHERE title = @subject), " +
                "   (SELECT id FROM collectives WHERE title = @collective), " +
                "   (SELECT id FROM classrooms WHERE title = @classroom), " +
                "   @sub_group" +
                "); ";

        foreach (var lesson in lessons)
        {
            using var cmd = new NpgsqlCommand(query, conn);

            cmd.Parameters.AddWithValue("@study_date", date);
            cmd.Parameters.AddWithValue("@class_index", lesson.ClassIndex);
            cmd.Parameters.AddWithValue("@teacher", lesson.Teacher);
            cmd.Parameters.AddWithValue("@subject", lesson.Subject);
            cmd.Parameters.AddWithValue("@collective", lesson.Collective);
            cmd.Parameters.AddWithValue("@classroom", lesson.Classroom);
            cmd.Parameters.AddWithValue("@sub_group", lesson.SubGroup);

            rows += await cmd.ExecuteNonQueryAsync();
        }

        return rows;
    }

    public async Task<List<ScheduleItem>> GetByDate(DateTime date)
    {
        var list = new List<ScheduleItem>();
        var dtSchedule = new DataTable();

        int rows = 0;

        using var conn = new NpgsqlConnection(_connectionString);
        string query;

        query = "SELECT " +
                "class_index, " +
                "(SELECT title FROM teachers WHERE id = teacher_id) AS teacher, " +
                "(SELECT title FROM subjects WHERE id = subject_id) AS subject, " +
                "(SELECT title FROM collectives WHERE id = collective_id) AS collective, " +
                "(SELECT title FROM classrooms WHERE id = classroom_id) AS classroom, " +
                "sub_group " +
                "FROM teachers_activity " +
                "WHERE schedule_id = (SELECT id FROM schedules WHERE study_date = @date)";

        using (var cmd = new NpgsqlCommand(query, conn))
        {
            cmd.Parameters.AddWithValue("@date", date);
            await conn.OpenAsync();
            NpgsqlDataReader dataReader = await cmd.ExecuteReaderAsync();
            dtSchedule.Load(dataReader);
        }

        foreach (DataRow row in dtSchedule.Rows)
        {
            list.Add(new ScheduleItem
            {
                ClassIndex = (int)row["class_index"],
                Teacher = (string)row["teacher"],
                Subject = (string)row["subject"],
                Collective = (string)row["collective"],
                Classroom = (string)row["classroom"],
                SubGroup = (int)row["sub_group"]
            });
        }

        return list;
    }
}
