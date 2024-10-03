using System;
using Microsoft.AspNetCore.Antiforgery;
using System.ComponentModel.DataAnnotations;
namespace ChoreApp.Api.Dtos.GroupDtos
{
	public record class CreateGroupDto
	(
		[Required]
		string Name
	);




}


