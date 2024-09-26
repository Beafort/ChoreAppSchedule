using ChoreApp.Api.Dtos.UserDtos;
using ChoreApp.Api.Entities;

namespace ChoreApp.Api.Mappings;

public static class UserMapping
{
	public static UserSummaryDto ToUserSummary(this User user)
	{
		return new UserSummaryDto
		(
			user.Id,
			user.Email!,
			user.Name!,
			user.Chores
		);
	}

}
