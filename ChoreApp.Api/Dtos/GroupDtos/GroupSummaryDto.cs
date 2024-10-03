using ChoreApp.Api.Entities;

namespace ChoreApp.Api.Dtos.GroupDtos
{
	public record class GroupSummaryDto
	(
		int Id,
		string Name,
		List<User> Users,
		List<Chore> Chores
	);
}



