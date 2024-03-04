namespace KTKGuest.Web.Abstractions.Repositories;

public interface ICollectivesRepositoty
{
    Task<List<string>> GetActiveCollectivesAsync();
    Task<List<DictionaryItem>> GetAllCollectivesAsync();
    Task<int> AddCollectivesAsync(List<string> list);
}
