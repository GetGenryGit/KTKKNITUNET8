using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace KTKGuest.Shared.Models;

public class FeedbackContent
{
    [JsonPropertyName("id")]
    public int Id { get; set; }

    [JsonPropertyName("name")]
    [Required(ErrorMessage = "Поле имя не может быть пустым!")]
    [Length(1, 64, ErrorMessage = "Имя может быть от 1 символов до 64.")]
    public string? Name { get; set; }

    [JsonPropertyName("email")]
    [Required(ErrorMessage = "Пожалуйста введите почту!")]
    [Length(4, 64, ErrorMessage = "Эл. почта должна быть от 4 символов до 64.")]
    [EmailAddress(ErrorMessage = "Введите валидную почту!")]
    public string? Email { get; set; }

    [JsonPropertyName("content")]
    [Required(ErrorMessage = "Текст сообщения не может быть пустым!")]
    [Length(4, 256, ErrorMessage = "Текст сообщения должен быть от 4 до 256 символов")]
    public string? Content { get; set; }
}
