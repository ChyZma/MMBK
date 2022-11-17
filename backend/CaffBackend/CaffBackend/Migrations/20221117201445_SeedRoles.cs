using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CaffBackend.Migrations
{
    public partial class SeedRoles : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[] { "41b48d54-1cd2-4954-a387-f271bd6b834e", "62845b0e-81e1-429f-92cc-43e44617a63a", "Admin", "ADMIN" });

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[] { "96c15064-7ade-4ea8-b709-803270058f51", "eb8ef37b-b543-4c04-bc39-ede95c2e48e8", "User", "USER" });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "41b48d54-1cd2-4954-a387-f271bd6b834e");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "96c15064-7ade-4ea8-b709-803270058f51");
        }
    }
}
