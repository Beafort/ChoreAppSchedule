using System;
using System.ComponentModel.DataAnnotations;

namespace ChoreApp.Api.Dtos
{
	public record class UpdateChoreDto
	(
		string Name,
		DateTime Deadline,
		int AssignedUserId,
		bool Done
	);
}


