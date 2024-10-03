

namespace ChoreApp.Api.Entities;

public class Chore
{
    public int Id { get; set; }
    public required string Name { get; set; }
    public DateTime Deadline { get; set; }
    public DateTime CreatedAt { get; set; }
    public virtual User? AssignedUser { get; set; }
    public bool Done { get; set; }
}