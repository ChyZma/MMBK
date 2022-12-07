using CaffBackend.Config;
using DataAccess;
using DataAccess.Constants;
using DataAccess.Entities;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using Microsoft.AspNetCore.Authentication;
using System.Diagnostics.Contracts;
using CaffBackend.Middlewares;
using Microsoft.Extensions.Logging;
using Serilog;
using System.Data;

var logConfig = new ConfigurationBuilder()
    .AddJsonFile("appsettings.json")
    .Build();

Log.Logger = new LoggerConfiguration()
    .ReadFrom.Configuration(logConfig)
    .CreateLogger();

try
{
    Log.Information("Starting web application");
    var builder = WebApplication.CreateBuilder(args);

    builder.Host.UseSerilog();

    // Add services to the container.
    ConfigurationManager configuration = builder.Configuration;
    builder.Services.AddControllers();
    // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
    builder.Services.AddEndpointsApiExplorer();
    builder.Services.AddSwaggerGen();
    builder.Services.AddDbContext<CaffContext>(options =>
    {
#if DEBUG
        options.UseInMemoryDatabase("CaffDb");
#else
    options.UseSqlServer(
            configuration.GetConnectionString("DefaultConnection"),
            b => b.MigrationsAssembly("CaffBackend")
        );
#endif
    });

    builder.Services.AddIdentity<User, IdentityRole>()
        .AddEntityFrameworkStores<CaffContext>()
        .AddDefaultTokenProviders();

    builder.Services.Configure<IdentityOptions>(options =>
    {
        // Password settings.
        options.Password.RequireDigit = true;
        options.Password.RequireLowercase = true;
        options.Password.RequireNonAlphanumeric = true;
        options.Password.RequireUppercase = true;
        options.Password.RequiredLength = 6;
        options.Password.RequiredUniqueChars = 1;

        // Lockout settings.
        options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromMinutes(5);
        options.Lockout.MaxFailedAccessAttempts = 5;
        options.Lockout.AllowedForNewUsers = true;

        // User settings.
        options.User.AllowedUserNameCharacters =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._@+";
        options.User.RequireUniqueEmail = false;
    });

    builder.Services.AddAuthentication(options =>
    {
        options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
        options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
        options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
    }).AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters()
        {
            ValidateIssuer = true,
            ValidateAudience = false,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = configuration["Jwt:Issuer"],
            IssuerSigningKey = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(configuration["Jwt:Key"])
            )
        };
    });

    builder.Services.AddManagers();
    var app = builder.Build();

    // Configure the HTTP request pipeline.
    if (app.Environment.IsDevelopment())
    {
        app.UseSwagger();
        app.UseSwaggerUI();

        //seed database
        using (var scope = app.Services.CreateScope())
        {
            var context = scope.ServiceProvider.GetRequiredService<CaffContext>();
            context.Database.EnsureCreated();

            var userManager = scope.ServiceProvider.GetRequiredService<UserManager<User>>();

            var admin = new User
            {
                UserName = "admin",
                Email = "admin@admin.admin",
                NormalizedUserName = "ADMIN",
                NormalizedEmail = "ADMIN@ADMIN.ADMIN"
            };

            var user = new User
            {
                UserName = "bence",
                Email = "user@user@user",
                NormalizedUserName="BENCE",
                NormalizedEmail= "USER@USER@USER"
             
            };
            context.Users.Add(admin);
            context.Users.Add(user);
            context.SaveChanges();
            var r1 = userManager.AddPasswordAsync(admin, "asdf1234A.").Result;
            var roles = new List<string> {
                UserRoleConstants.Admin,
                UserRoleConstants.User
            };
            var r2 = userManager.AddToRolesAsync(admin, roles).Result;

            var r3 = userManager.AddPasswordAsync(user, "asdf1234A.").Result;
            var r4 = userManager.AddToRoleAsync(user, UserRoleConstants.User).Result;
        }
    }

    app.UseSerilogRequestLogging();

    app.UseHttpsRedirection();

    app.UseAuthentication();
    app.UseMiddleware<CurrentUserMiddleware>();
    app.UseAuthorization();

    app.MapControllers();

    app.Run();
}
catch (Exception ex)
{
    Log.Fatal(ex, "Application terminated unexpectedly");
}
finally
{
    Log.CloseAndFlush();
}

//Needed for integration testing
public partial class Program { }