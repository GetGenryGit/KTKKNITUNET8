namespace KTKGuest.Shared.Abstractions.Services;

public interface IDictionariesService
{
    Task<List<string>> GetList(DictionaryType type);
}
