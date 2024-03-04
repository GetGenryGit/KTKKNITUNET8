using System.Text.Json.Serialization;

namespace KTKGuest.Web.Models;

public class UserDto
{
    [JsonPropertyName("id")]
    public int Id { get; set; }
    [JsonPropertyName("login")]
    public string? Login { get; set; }
    [JsonPropertyName("password")]
    public string? Password { get; set; }
    [JsonPropertyName("role")]
    public string? Role { get; set; }
}
