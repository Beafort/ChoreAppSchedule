using ChoreApp.Api.Dtos;
using ChoreApp.Api.Dtos.GroupDtos;
using ChoreApp.Api.Entities;

namespace ChoreApp.Api.Mappings;

public static class GroupMapping
{
	public static GroupSummaryDto ToGroupSummary(this Group group)
	{
		return new GroupSummaryDto(
			group.Id,
			group.Name,
			group.Users,
			group.Chores
		);
	}
	public static GroupDetailsDto ToGroupDetails(this Group group)
	{
		return new GroupDetailsDto(
			group.Id,
			group.Name,
			group.Users.Select(u => u.Id).ToList(),
			group.Chores.Select(c => c.Id).ToList()
		);
	}
	public static Group ToGroupEntity(this CreateGroupDto newGroup)
	{
		return new Group()
		{
			Name = newGroup.Name,	
		};
	}
	public static Group ToGroupEntity(this UpdateGroupDto updatedGroup, List<User> updatedUsers, List<Chore> udpatedChores)
	{
		return new Group()
		{
			Name = updatedGroup.Name,
			Users = updatedUsers,
			Chores = udpatedChores
		};
	}
}
