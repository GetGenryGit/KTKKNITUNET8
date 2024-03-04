using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace KTKGuest.Shared.Models;

public class APIResponse
{
    [JsonPropertyName("result")]
    public bool Result { get; set; }
    [JsonPropertyName("message")]
    public string? Message { get; set; }
    [JsonPropertyName("obj")]
    public object? Obj { get; set; }
}
