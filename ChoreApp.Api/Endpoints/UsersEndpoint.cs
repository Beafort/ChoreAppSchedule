using System.Net;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using ChoreApp.Api.Data;
using ChoreApp.Api.Dtos;
using ChoreApp.Api.Entities;

using ChoreApp.Api.Mappings;
using Microsoft.IdentityModel.Tokens;
using ChoreApp.Api.Dtos.UserDtos;
using Microsoft.AspNetCore.Identity;
using System.Security.Claims;
using Microsoft.AspNetCore.Mvc;

namespace ChoreApp.Api.Endpoints;

public static class UsersEndpoints
{

	const string GetChoresEndpointsName = "GetUser";
	public static RouteGroupBuilder MapUsersEndpoints(this WebApplication app)
	{
		var group = app.MapGroup("user");
		group.MapPost("/register", async (RegisterDto registerDto, UserManager<User> userManager) =>
		{
			var user = new User
			{
				UserName = registerDto.Email,
				Email = registerDto.Email,
				Name = registerDto.Name 
			};

			var result = await userManager.CreateAsync(user, registerDto.Password);
			
			if (result.Succeeded)
			{
				return Results.Ok(new { Message = "User registered successfully" });
			}

			return Results.BadRequest(result.Errors);
		});
	
		group.MapGet("/info", async ( UserManager<User> userManager, ChoreAppContext dbContext, ClaimsPrincipal claims) => 
		{
			string userId = claims.Claims.First(c => c.Type == ClaimTypes.NameIdentifier).Value;
			User? user = await userManager.FindByIdAsync(userId);
			if(user is null)
			{
				return Results.NotFound();
				
			}	
			if(user.ChoresId != null)
			{
				var chores = await dbContext.Chores
				.Where(c => user.ChoresId.Contains(c.Id))
				.ToListAsync();
				user.Chores = chores;
			}
			
			
			return Results.Ok(user.ToUserSummary());		
		}).RequireAuthorization();
		group.MapDelete("/{id}", async (string id, UserManager<User> userManager, ChoreAppContext dbContext) => 
		{
			User? user = await userManager.FindByIdAsync(id);
			
			if(user is null)
			{
				return Results.NotFound();
				
			}	
			await userManager.DeleteAsync(user);
			return Results.NoContent();
		}).RequireAuthorization();
		group.MapPut("/{id}/chores", async (string id, UpdateUserChoresDto updatedUser, UserManager<User> userManager, ChoreAppContext dbContext) => 
		{
			User? user = await userManager.FindByIdAsync(id);
			if(user is null)
			{
				return Results.NotFound();
				
			}
			var chores = await dbContext.Chores
				.Where(c => updatedUser.ChoreIds.Contains(c.Id))
				.ToListAsync();
			user.Chores = chores;
			user.ChoresId = updatedUser.ChoreIds;
			
			var result = await userManager.UpdateAsync(user);
			if(result.Succeeded)
			{
				return Results.Ok(user);
			}
			return Results.BadRequest(result.Errors);
		}).RequireAuthorization();
		group.MapPost("/logout", async (SignInManager<User> signInManager,
			[FromBody] object empty) =>
		{
			if (empty != null)
			{
				await signInManager.SignOutAsync();
				return Results.Ok();
			}
			return Results.Unauthorized();
		})
		.RequireAuthorization();
		return group;
	}
}