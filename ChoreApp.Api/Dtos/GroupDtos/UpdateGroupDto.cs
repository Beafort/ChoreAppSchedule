using System;
using System.ComponentModel.DataAnnotations;

namespace ChoreApp.Api.Dtos.GroupDtos
{
	public record class UpdateGroupDto
	(
		string Name,
		List<string> UsersId,
		List<string> ChoresId
	);
}


