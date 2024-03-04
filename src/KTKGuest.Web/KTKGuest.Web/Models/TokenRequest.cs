using System.Text.Json.Serialization;

namespace KTKGuest.Web.Models
{
    public class TokenRequest
    {
        [JsonPropertyName("token")]
        public string? Token { get; set; }
    }

}
