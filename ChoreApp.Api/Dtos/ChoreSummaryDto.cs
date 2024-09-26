using ChoreApp.Api.Endpoints;
using Microsoft.Identity.Client;

namespace ChoreApp.Api.Dtos
{
    public record class ChoreSummaryDto
    (
        int Id,
        string Name,
        DateTime Deadline,
        bool Done,
        string? AssignedUser,
        DateTime CreatedAt
    );
}



