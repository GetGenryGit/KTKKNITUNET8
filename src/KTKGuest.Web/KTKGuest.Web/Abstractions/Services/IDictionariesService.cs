using KTKGuest.Web.Enums;

namespace KTKGuest.Web.Abstractions.Services;

public interface IDictionariesService
{
    Task<List<string>> GetActive(DictionaryType type);
    Task<List<DictionaryItem>> GetAll(DictionaryType type);
    Task<bool> Add(DictionaryType type, List<string> list);
}
