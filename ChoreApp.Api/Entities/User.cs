using ChoreApp.Api.Entities;
using Microsoft.AspNetCore.Identity;
namespace ChoreApp.Api.Entities;
public class User : IdentityUser
{
	
	public string? Name { get; set; }
    public virtual List<Group> Groups { get; set; } = new List<Group>();
    public List<Chore>? Chores { get; set; } = new List<Chore>();
}