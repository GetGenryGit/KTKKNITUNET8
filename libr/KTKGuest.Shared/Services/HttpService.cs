using KTKGuest.Shared.Models;
using System.Net.Http.Json;
using System.Text.Json;
using System.Text;
using KTKGuest.Shared.Abstractions.Services;

namespace KTKGuest.Shared.Services;

public class HttpService : IHttpService
{
    private readonly HttpClient _httpClient;
    public HttpService(HttpClient httpClient)
    {
         _httpClient = httpClient;
    }

    public async Task<APIResponse> Get(string uri)
    {
        var request = new HttpRequestMessage(HttpMethod.Get, uri);  
        return await sendRequest(request);
    }

    public async Task<APIResponse> Post(string uri, object value)
    {
        var request = new HttpRequestMessage(HttpMethod.Post, uri);
        request.Content = new StringContent(JsonSerializer.Serialize(value), Encoding.UTF8, "application/json");
        return await sendRequest(request);
    }

    public async Task<APIResponse> sendRequest(HttpRequestMessage request)
    {
        var response = await _httpClient.SendAsync(request);
        if (!response.IsSuccessStatusCode)
        {
            var error = await response.Content.ReadFromJsonAsync<Dictionary<string, string>>();
            throw new Exception(error["message"]);
        }

        return await response.Content.ReadFromJsonAsync<APIResponse>();
    }
}
