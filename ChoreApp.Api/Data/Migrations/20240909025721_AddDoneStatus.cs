using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ChoreApp.Api.Data.Migrations
{
    /// <inheritdoc />
    public partial class AddDoneStatus : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "Done",
                table: "Chores",
                type: "bool",
                nullable: false,
                defaultValue: false);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Done",
                table: "Chores");
        }
    }
}
