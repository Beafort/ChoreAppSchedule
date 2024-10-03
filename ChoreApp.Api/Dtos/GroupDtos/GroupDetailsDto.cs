using ChoreApp.Api.Entities;

namespace ChoreApp.Api.Dtos.GroupDtos
{
	public record class GroupDetailsDto
	(
		int Id,
		string Name,
		List<string> UsersId,
		List<int> ChoresId
	);
}



