namespace ChoreApp.Api.Dtos
{
	public record class ChoreSummaryDto
	(
		int Id,
		string Name,
		DateTime Deadline,
		bool Done
	);
}



