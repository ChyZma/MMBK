using BusinessLogic.Common;
using BusinessLogic.Managers;
using DataAccess;
using DataAccess.Constants;
using DataAccess.Entities;
using Microsoft.AspNetCore.Identity;
using Moq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogic.Tests
{
    public class CurrentUserTests
    {
        Mock<UserManager<User>> _userManagerMock;
        CurrentUser _currentUser;

        [SetUp]
        public void Setup()
        {
            _userManagerMock = new Mock<UserManager<User>>(new Mock<IUserStore<User>>().Object, null, null, null, null, null, null, null, null);
            _userManagerMock.Setup(u => u.GetUserId(It.IsAny<ClaimsPrincipal>())).Returns("1");
            _currentUser = new CurrentUser(_userManagerMock.Object);
        }

        [Test]
        public void WhenUserIsAdminIsAdminReturnsTrue()
        {
            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Name, "testuser"),
                new Claim(ClaimTypes.Role, UserRoleConstants.User),
                new Claim(ClaimTypes.Role, UserRoleConstants.Admin)
            };
            _currentUser.SetUser(new ClaimsPrincipal(new ClaimsIdentity(claims)));

            Assert.IsTrue(_currentUser.IsAdmin);
        }

        [Test]
        public void WhenUserIsNotAdminIsAdminReturnsFalse()
        {
            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Name, "testuser"),
                new Claim(ClaimTypes.Role, UserRoleConstants.User),
            };
            _currentUser.SetUser(new ClaimsPrincipal(new ClaimsIdentity(claims)));
            Assert.IsFalse(_currentUser.IsAdmin);
        }

        [Test]
        public void WhenUserIsAdminIdReturnsUserId()
        {
            _userManagerMock.Setup(u => u.IsInRoleAsync(It.IsAny<User>(), "Admin")).ReturnsAsync(true);
            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Name, "testuser"),
                new Claim(ClaimTypes.Role, UserRoleConstants.Admin),
            };
            _currentUser.SetUser(new ClaimsPrincipal(new ClaimsIdentity(claims)));
            Assert.That(_currentUser.Id, Is.EqualTo("1"));
        }

        [Test]
        public void WhenUserIsNotAdminIdReturnsUserId()
        {
            _userManagerMock.Setup(u => u.IsInRoleAsync(It.IsAny<User>(), "Admin")).ReturnsAsync(false);
            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Name, "testuser"),
                new Claim(ClaimTypes.Role, UserRoleConstants.User),
            };
            _currentUser.SetUser(new ClaimsPrincipal(new ClaimsIdentity(claims)));
            Assert.That(_currentUser.Id, Is.EqualTo("1"));
        }
    }
}
