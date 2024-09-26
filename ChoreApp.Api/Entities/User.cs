using ChoreApp.Api.Entities;
using Microsoft.AspNetCore.Identity;
namespace ChoreApp.Api.Entities;
public class User : IdentityUser
{
	
	public string? Name { get; set; }
	
	public List<Chore>? Chores { get; set; }
	
	public List<int>? ChoresId { get; set; }
}