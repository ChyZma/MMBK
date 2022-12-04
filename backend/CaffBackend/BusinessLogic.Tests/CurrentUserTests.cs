using BusinessLogic.Common;
using BusinessLogic.Managers;
using DataAccess;
using DataAccess.Entities;
using Microsoft.AspNetCore.Identity;
using Moq;
using System;
using System.Collections.Generic;
using System.Linq;
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
            _userManagerMock = new Mock<UserManager<User>>();
            _currentUser = new CurrentUser(_userManagerMock.Object);
        }

        [Test]
        public void Test1()
        {
            Assert.Pass();
        }
    }
}
