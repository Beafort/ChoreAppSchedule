using System.Net;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using ChoreApp.Api.Data;
using ChoreApp.Api.Dtos;
using ChoreApp.Api.Entities;

using ChoreApp.Api.Mappings;
using Microsoft.IdentityModel.Tokens;
using ChoreApp.Api.Dtos.GroupDtos;

namespace ChoreApp.Api.Endpoints;

public static class GroupsEndpoints
{

	const string GetGroupEndpointsName = "GetGroup";
	public static RouteGroupBuilder MapGroupsEndpoints(this WebApplication app)
	{
		var group = app.MapGroup("groups");
		group.MapGet("/", async (ChoreAppContext dbContext) =>
		{
			var GroupDtos = await dbContext.Groups.Include(group => group.Chores)
													.Include(group => group.Users)
													.Select(group => group.ToGroupSummary())
													.AsNoTracking()
													.ToListAsync();
			return GroupDtos;
		});
		group.MapPost("/", async (ChoreAppContext dbContext, CreateGroupDto newGroup) => 
		{
			Group group = newGroup.ToGroupEntity();
			dbContext.Groups.Add(group);
			await dbContext.SaveChangesAsync();
			return Results.CreatedAtRoute(GetGroupEndpointsName, new { id = group.Id }, group.ToGroupSummary());
		});
		return group;
	}
}