namespace KTKGuest.Web.Abstractions.Repositories;

public interface IClassroomsRepository
{
    Task<List<string>> GetActiveClassroomsAsync();
    Task<List<DictionaryItem>> GetAllClassroomsAsync();
    Task<int> AddClassroomsAsync(List<string> list);
}
