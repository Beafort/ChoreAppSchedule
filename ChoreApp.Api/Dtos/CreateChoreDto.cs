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
		bool Done = false
	);
	
		
		
	
}


