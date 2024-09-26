using System;
using Microsoft.AspNetCore.Antiforgery;
using System.ComponentModel.DataAnnotations;
namespace ChoreApp.Api.Dtos
{
	public record class CreateChoreDto
	(
		[Required]
		string Name,
		[Required]
		DateTime Deadline,
		int AssignedUserId,
		bool Done = false
	);




}


