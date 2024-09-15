using Microsoft.EntityFrameworkCore;

namespace ChoreApp.Api.Data;

public static class DataExtensions
{
    public static async Task MigrateDbAsync(this WebApplication app)
	{
		using var scope = app.Services.CreateScope();
		var DbContext = scope.ServiceProvider.GetRequiredService<ChoreAppContext>();
		await DbContext.Database.MigrateAsync();
	}
}
