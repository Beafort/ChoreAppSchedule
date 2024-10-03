using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ChoreApp.Api.Data.Migrations
{
    /// <inheritdoc />
    public partial class Fix : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Groups",
                type: "text",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "text",
                oldNullable: true);

            migrationBuilder.AddColumn<int>(
                name: "GroupId",
                table: "Chores",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Chores_GroupId",
                table: "Chores",
                column: "GroupId");

            migrationBuilder.AddForeignKey(
                name: "FK_Chores_Groups_GroupId",
                table: "Chores",
                column: "GroupId",
                principalTable: "Groups",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Chores_Groups_GroupId",
                table: "Chores");

            migrationBuilder.DropIndex(
                name: "IX_Chores_GroupId",
                table: "Chores");

            migrationBuilder.DropColumn(
                name: "GroupId",
                table: "Chores");

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Groups",
                type: "text",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "text");
        }
    }
}
