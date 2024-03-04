using KTKGuest.Shared.Models;

namespace KTKGuest.Shared.Abstractions.Services;

public interface IHttpService
{
    Task<APIResponse> Get(string uri);
    Task<APIResponse> Post(string uri, object value);
}
