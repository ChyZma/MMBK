using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CaffBackend.Migrations
{
    public partial class RemoveNameFromUserAndAddEnabledToCaffAndOwnershipToUsers : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "41b48d54-1cd2-4954-a387-f271bd6b834e");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "96c15064-7ade-4ea8-b709-803270058f51");

            migrationBuilder.DropColumn(
                name: "FirstName",
                table: "AspNetUsers");

            migrationBuilder.DropColumn(
                name: "LastName",
                table: "AspNetUsers");

            migrationBuilder.AddColumn<bool>(
                name: "Enabled",
                table: "CaffFiles",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.CreateTable(
                name: "CaffFileUser",
                columns: table => new
                {
                    OwnedCaffFilesId = table.Column<int>(type: "int", nullable: false),
                    OwnersId = table.Column<string>(type: "nvarchar(450)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CaffFileUser", x => new { x.OwnedCaffFilesId, x.OwnersId });
                    table.ForeignKey(
                        name: "FK_CaffFileUser_AspNetUsers_OwnersId",
                        column: x => x.OwnersId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_CaffFileUser_CaffFiles_OwnedCaffFilesId",
                        column: x => x.OwnedCaffFilesId,
                        principalTable: "CaffFiles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[] { "20eb9874-dde4-474b-a7c4-fa28564e0be5", "e9684993-923a-44ef-89c1-8a80ba645d6e", "User", "USER" });

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[] { "342d42d0-606e-4512-bbb8-e2e276a76cf2", "cf6d550e-5635-4f1a-b25f-93bf6cdc5a82", "Admin", "ADMIN" });

            migrationBuilder.CreateIndex(
                name: "IX_CaffFileUser_OwnersId",
                table: "CaffFileUser",
                column: "OwnersId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "CaffFileUser");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "20eb9874-dde4-474b-a7c4-fa28564e0be5");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "342d42d0-606e-4512-bbb8-e2e276a76cf2");

            migrationBuilder.DropColumn(
                name: "Enabled",
                table: "CaffFiles");

            migrationBuilder.AddColumn<string>(
                name: "FirstName",
                table: "AspNetUsers",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "LastName",
                table: "AspNetUsers",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[] { "41b48d54-1cd2-4954-a387-f271bd6b834e", "62845b0e-81e1-429f-92cc-43e44617a63a", "Admin", "ADMIN" });

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[] { "96c15064-7ade-4ea8-b709-803270058f51", "eb8ef37b-b543-4c04-bc39-ede95c2e48e8", "User", "USER" });
        }
    }
}
