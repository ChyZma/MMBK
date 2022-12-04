using BusinessLogic.Common;
using CaffBackend.Requests;
using CaffBackend.Responses;
using DataAccess.Constants;
using DataAccess.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace CaffBackend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class UserController : ControllerBase
    {
        private readonly UserManager<User> _userManager;
        private readonly IConfiguration _configuration;

        public UserController(UserManager<User> userManager,
            IConfiguration configuration)
        {
            _userManager = userManager;
            _configuration = configuration;
        }

        [AllowAnonymous]
        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] RegisterRequest request)
        {
            var userExists = await _userManager.FindByNameAsync(request.UserName);
            if (userExists != null)
            {
                return StatusCode(409, "User already exists!");
            }

            User user = new User()
            {
                Email = request.Email,
                SecurityStamp = Guid.NewGuid().ToString(),
                UserName = request.UserName,
            };

            var result = await _userManager.CreateAsync(user, request.Password);
            if (!result.Succeeded)
            {
                return StatusCode(500, "User creation failed! Please check user details and try again.");
            }

            await _userManager.AddToRoleAsync(user, UserRoleConstants.User);

            return Ok("User created successfully!");
        }

        [HttpPost("login")]
        [AllowAnonymous]
        public async Task<IActionResult> Login([FromBody] LoginRequest request)
        {
            var user = await _userManager.FindByNameAsync(request.UserName);
            if (user != null && await _userManager.CheckPasswordAsync(user, request.Password))
            {
                var userRoles = await _userManager.GetRolesAsync(user);

                var authClaims = new List<Claim>
                {
                    new Claim(ClaimTypes.Name, user.UserName),
                    new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                };

                foreach (var userRole in userRoles)
                {
                    authClaims.Add(new Claim(ClaimTypes.Role, userRole));
                }

                var authSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]));

                var token = new JwtSecurityToken(
                    issuer: _configuration["Jwt:Issuer"],
                    expires: DateTime.Now.AddHours(3),
                    claims: authClaims,
                    signingCredentials: new SigningCredentials(authSigningKey, SecurityAlgorithms.HmacSha256)
                );

                return Ok(new
                {
                    token = new JwtSecurityTokenHandler().WriteToken(token),
                    expiration = token.ValidTo
                });
            }
            return Unauthorized();
        }

        [HttpPost("make-admin")]
        [Authorize(Roles = UserRoleConstants.Admin)]
        public async Task<IActionResult> MakeAdmin([FromBody] MakeAdminRequest request)
        {
            var user = await _userManager.FindByIdAsync(request.UserId);
            if (user == null)
                return StatusCode(404, "User not found!");

            var result = await _userManager.AddToRoleAsync(user, UserRoleConstants.Admin);
            if (!result.Succeeded)
                return StatusCode(500, "User role change failed! Please check user details and try again.");

            return Ok("User role changed successfully!");
        }

        [HttpDelete("{id}")]
        [Authorize(Roles = UserRoleConstants.Admin)]
        public IActionResult DeleteUser(string id)
        {
            var currentUser = HttpContext.User;

            var userToDelete = _userManager.FindByIdAsync(id).Result;

            if (userToDelete == null)
            {
                return StatusCode(404, "User not found!");
            }

            if (_userManager.IsInRoleAsync(userToDelete, UserRoleConstants.Admin).Result)
            {
                return StatusCode(403, "You are not authorized to delete admins!");
            }

            if (currentUser.Identity is not null && userToDelete.UserName == currentUser.Identity.Name)
            {
                return StatusCode(403, "You cannot delete yourself!");
            }

            _userManager.DeleteAsync(userToDelete);
            return Ok("User deleted successfully!");
        }

        [HttpGet]
        [Authorize(Roles = UserRoleConstants.Admin)]
        public ActionResult<List<UserResponse>> ListAllUsers()
        {
            return _userManager.Users
                .Select(u => new UserResponse
                {
                    Id = u.Id,
                    UserName = u.UserName,
                    Email = u.Email,
                    Roles = _userManager.GetRolesAsync(u).Result.ToList()
                })
                .ToList();
        }

    }
}
