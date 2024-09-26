using ChoreApp.Api.Entities;

namespace ChoreApp.Api.Dtos.UserDtos
{
	public record class UserSummaryDto
	(
		string Id,
		string Email,
		string Name,
		List<Chore>? Chores
	);
}
