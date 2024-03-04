using System.Text.Json.Serialization;

namespace KTKGuest.Web.Models;

public class UserDetails
{
    [JsonPropertyName("login")]
    public string? Login { get; set; }
    [JsonPropertyName("role")]
    public string? Role { get; set; }
}
