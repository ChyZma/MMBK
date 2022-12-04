using CaffBackend.Requests;
using DataAccess.Constants;
using DataAccess.Entities;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using Microsoft.VisualStudio.TestPlatform.TestHost;
using Newtonsoft.Json;
using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Net.Http.Headers;
using System.Security.Claims;
using System.Text;

namespace IntegrationTests
{
    public class CaffControllerIntegrationTests
    {
        private WebApplicationFactory<Program> _factory;
        private HttpClient _client;
        private ConfigurationManager _configuration;

        [OneTimeSetUp]
        public void SetUp()
        {
            _configuration = new ConfigurationManager();
            _configuration["Jwt:Key"] = "TestKey123-12312321";
            _configuration["Jwt:Issuer"] = "testissuer";
            _factory = new WebApplicationFactory<Program>().WithWebHostBuilder(c => c.UseConfiguration(_configuration));
            _client = _factory.CreateDefaultClient();
        }

        private string GetValidToken()
        {
            var authClaims = new List<Claim>
                {
                    new Claim(ClaimTypes.Name, "admin"),
                    new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                    new Claim(ClaimTypes.Role, UserRoleConstants.User),
                    new Claim(ClaimTypes.Role, UserRoleConstants.Admin)
                };


            var authSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]));

            var token = new JwtSecurityToken(
                issuer: _configuration["Jwt:Issuer"],
                expires: DateTime.Now.AddHours(3),
                claims: authClaims,
                signingCredentials: new SigningCredentials(authSigningKey, SecurityAlgorithms.HmacSha256)
            );

            return new JwtSecurityTokenHandler().WriteToken(token);

        }

        [Test]
        public void CallingAnyRequestWithoutAuthorizationTokenResultsIn401()
        {
            _client = _factory.CreateDefaultClient();
            var response1 = _client.PostAsync("/api/caff", new StringContent("")).Result;
            var response2 = _client.GetAsync($"/api/caff/{1}").Result;
            var response3 = _client.DeleteAsync($"/api/caff/{1}").Result;
            var response4 = _client.GetAsync("/api/caff").Result;
            var response5 = _client.GetAsync($"/api/caff/{1}/preview").Result;
            Assert.That(response1.StatusCode, Is.EqualTo(HttpStatusCode.Unauthorized));
            Assert.That(response2.StatusCode, Is.EqualTo(HttpStatusCode.Unauthorized));
            Assert.That(response3.StatusCode, Is.EqualTo(HttpStatusCode.Unauthorized));
            Assert.That(response4.StatusCode, Is.EqualTo(HttpStatusCode.Unauthorized));
            Assert.That(response5.StatusCode, Is.EqualTo(HttpStatusCode.Unauthorized));
        }

        [Test]
        public void AnyEndpointWithBearerTokenIsNotUnauthorized()
        {
            _client = _factory.CreateDefaultClient();
            _client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", GetValidToken());
            
            var response1 = _client.PostAsync("/api/caff", new StringContent("")).Result;
            var response2 = _client.GetAsync($"/api/caff/{1}").Result;
            //var response3 = _client.DeleteAsync($"/api/caff/{1}").Result;
            var response4 = _client.GetAsync("/api/caff").Result;
            var response5 = _client.GetAsync($"/api/caff/{1}/preview").Result;
            Assert.That(response1.StatusCode, Is.Not.EqualTo(HttpStatusCode.Unauthorized));
            Assert.That(response2.StatusCode, Is.Not.EqualTo(HttpStatusCode.Unauthorized));
            //Assert.That(response3.StatusCode, Is.Not.EqualTo(HttpStatusCode.Unauthorized));
            Assert.That(response4.StatusCode, Is.Not.EqualTo(HttpStatusCode.Unauthorized));
            Assert.That(response5.StatusCode, Is.Not.EqualTo(HttpStatusCode.Unauthorized));
        }

    }
}