using System.ComponentModel.DataAnnotations;

namespace KTKGuest.Web.Models;

public class LoginUser
{
    [Required(ErrorMessage = "Поле логин не может быть пустым!")]
    [Length(3, 30, ErrorMessage = "Логин должен быть от 3 символов до 30.")]

    public string Login { get; set; }
    [Required(ErrorMessage = "Поле пароль не может быть пустым!")]
    [Length(4, 50, ErrorMessage = "Пароль должен быть от 8 символов до 50.")]
    public string Password { get; set; }
}
