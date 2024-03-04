using System.Text.Json;
using KTKGuest.Shared.Abstractions.Services;

namespace KTKGuest.Shared.Services;

public class DictionariesService : IDictionariesService
{
    private readonly IHttpService _httpService;
    public DictionariesService(IHttpService httpService)
    {
        _httpService = httpService;
    }

    public async Task<List<string>> GetList(DictionaryType type)
    {
        var response = await _httpService.Get(APIConstants.GetDictionaries + $"?type={type}");

        return JsonSerializer.Deserialize<List<string>>(response.Obj.ToString());
    }
}
