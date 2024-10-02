using System.Net;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using ChoreApp.Api.Data;
using ChoreApp.Api.Dtos;
using ChoreApp.Api.Entities;

using ChoreApp.Api.Mappings;
using Microsoft.IdentityModel.Tokens;

namespace ChoreApp.Api.Endpoints;

public static class ChoresEndpoints
{

	const string GetChoresEndpointsName = "GetChore";
	public static RouteGroupBuilder MapChoresEndpoints(this WebApplication app)
	{
		var group = app.MapGroup("chores");
		group.MapGet("/", async (ChoreAppContext dbContext) =>
		{

			var choreDtos = await dbContext.Chores.Include(chore => chore.AssignedUser)
													.Select(chore => chore.ToChoreSummary())
													.AsNoTracking()
													.ToListAsync();
			return choreDtos;
		}).RequireAuthorization();
		group.MapGet("/{date:datetime}", async (DateOnly date, ChoreAppContext dbContext) =>
		{
			var chores = await dbContext.Chores
			.Where(c => DateOnly.FromDateTime(c.Deadline) == date)
			.Include(c => c.AssignedUser)
			.ToListAsync();

			if (chores.Count == 0) return Results.NotFound();

			return Results.Ok(chores.Select(c => c.ToChoreSummary()));
		});
		group.MapGet("/{id:int}", async (int id, ChoreAppContext dbContext) =>
		{
			var chore = await dbContext.Chores.FindAsync(id);
			if (chore == null) return Results.NotFound();
			return Results.Ok(chore.ToChoreDetails());
		}).WithName(GetChoresEndpointsName);

		group.MapPost("/", async (CreateChoreDto newChore, ChoreAppContext dbContext) =>
		{
			Chore chore = newChore.ToChoreEntity();
			chore.CreatedAt = DateTime.Now.ToUniversalTime();
			dbContext.Chores.Add(chore);
			await dbContext.SaveChangesAsync();
			return Results.CreatedAtRoute(GetChoresEndpointsName, new { id = chore.Id }, chore.ToChoreSummary());
		})
		.WithParameterValidation();
		group.MapDelete("/{id}", async (int id, ChoreAppContext dbContext) =>
		{
			await dbContext.Chores
					 .Where(chore => chore.Id == id)
					 .ExecuteDeleteAsync();
			return Results.NoContent();
		});
		group.MapPut("/{id}", async (int id, ChoreAppContext dbContext, UpdateChoreDto newChore) =>
		{
			var existingChore = await dbContext.Chores.FindAsync(id);
			if (existingChore is null)
			{
				return Results.NotFound();
			}
			dbContext.Entry(existingChore)
					 .CurrentValues
					 .SetValues(newChore.ToChoreEntity(id));
			await dbContext.SaveChangesAsync();
			return Results.NoContent();
		});

		return group;
	}
}