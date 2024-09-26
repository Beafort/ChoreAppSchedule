using ChoreApp.Api.Entities;
using Microsoft.Identity.Client;

namespace ChoreApp.Api.Dtos.UserDtos
{
	public record class UpdateUserChoresDto
	(
		List<int> ChoreIds
	);
}


