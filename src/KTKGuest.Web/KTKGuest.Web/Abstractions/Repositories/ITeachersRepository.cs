namespace KTKGuest.Web.Abstractions.Repositories;

public interface ITeachersRepository
{
    Task<List<string>> GetActiveTeachersAsync();
    Task<List<DictionaryItem>> GetAllTeachersAsync();
    Task<int> AddTeachersAsync(List<string> list);
}
