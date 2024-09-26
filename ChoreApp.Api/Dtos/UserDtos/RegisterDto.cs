using Microsoft.Identity.Client;

namespace ChoreApp.Api.Dtos.UserDtos
{
	public record class RegisterDto
	(
		string Email,
		string Password,
		string Name
	);
}


