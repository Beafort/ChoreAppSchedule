

using ChoreApp.Api.Data;
using ChoreApp.Api.Dtos;
using ChoreApp.Api.Endpoints;
using ChoreApp.Api.Entities;
using Microsoft.AspNetCore.Routing.Template;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

var connString = builder.Configuration.GetConnectionString("ChoreApp");
builder.Services.AddDbContext<ChoreAppContext>(
	options => options.UseNpgsql(connString)
);
builder.Services.AddAuthorization();
builder.Services.AddIdentityApiEndpoints<User>(options => options.User.RequireUniqueEmail = true)
		.AddEntityFrameworkStores<ChoreAppContext>();
var app = builder.Build();
app.MapIdentityApi<User>();
app.MapChoresEndpoints();
app.MapUsersEndpoints();
app.MapGroupsEndpoints();
await app.MigrateDbAsync();
app.Run();
