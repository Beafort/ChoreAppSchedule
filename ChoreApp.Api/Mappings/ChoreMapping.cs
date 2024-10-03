using ChoreApp.Api.Dtos;
using ChoreApp.Api.Entities;

namespace ChoreApp.Api.Mappings;

public static class ChoreMapping
{
	public static ChoreSummaryDto ToChoreSummary(this Chore chore)
	{
		return new ChoreSummaryDto
		(
			chore.Id,
			chore.Name,
			chore.Deadline,
			chore.Done,
			chore.AssignedUser != null ? chore.AssignedUser.Name : "Unassigned",
			chore.CreatedAt
		);
	}
	public static ChoreDetailsDto ToChoreDetails(this Chore chore)
	{
		return new ChoreDetailsDto
		(
			chore.Id,
			chore.Name,
			chore.Deadline,
			chore.Done,
			chore.AssignedUser != null ? chore.AssignedUser.Id : "Unassigned",
			chore.CreatedAt
		);
	}
	public static Chore ToChoreEntity(this CreateChoreDto chore)
	{
		return new Chore()
		{
			Name = chore.Name,
			Deadline = chore.Deadline
		};
	}
	public static Chore ToChoreEntity(this UpdateChoreDto chore, int id)
	{
		return new Chore()
		{
			Id = id,
			Name = chore.Name,
			Deadline = chore.Deadline,
			Done = chore.Done
		};
	}
}
