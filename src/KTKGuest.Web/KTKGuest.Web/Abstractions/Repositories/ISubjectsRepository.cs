namespace KTKGuest.Web.Abstractions.Repositories;

public interface ISubjectsRepository
{
    Task<List<string>> GetActiveSubjectsAsync();
    Task<List<DictionaryItem>> GetAllSubjectsAsync();
    Task<int> AddSubjectsAsync(List<string> list);
}
