namespace ChoreApp.Api.Dtos
{
    public record class ChoreDetailsDto
    (
        int Id,
        string Name,
        DateTime Deadline,
        bool Done,
        string AssignedUserId,
        DateTime CreatedAt
    );
}



