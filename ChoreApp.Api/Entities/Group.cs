using ChoreApp.Api.Entities;
using Microsoft.AspNetCore.Identity;
namespace ChoreApp.Api.Entities;
public class Group 
{
	public int Id { get; set; }
	public string Name { get; set; } = "";
	public virtual List<User> Users { get; set; } = new List<User>();
	public virtual List<Chore> Chores {get; set;} = [];
}