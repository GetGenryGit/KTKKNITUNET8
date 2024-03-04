using System.ComponentModel.DataAnnotations;

namespace KTKGuest.Web.Models;

public class NotificationContent
{
    [Required]
    public string Title { get; set; }
    [Required]
    public string Body { get; set; }
}
