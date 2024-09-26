

using ChoreApp.Api.Data;
using ChoreApp.Api.Dtos;
using ChoreApp.Api.Endpoints;
using Microsoft.AspNetCore.Routing.Template;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

var connString = builder.Configuration.GetConnectionString("ChoreApp");
builder.Services.AddDbContext<ChoreAppContext>(
		options => options.UseNpgsql(connString)
);
builder.Services.AddAuthorization();
var app = builder.Build();
app.MapChoresEndpoints();
await app.MigrateDbAsync();
app.Run();
