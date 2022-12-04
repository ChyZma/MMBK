using BusinessLogic.Common;
using BusinessLogic.Managers;
using DataAccess;
using DataAccess.Entities;
using Moq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogic.Tests
{
    public class CaffCommentManagerTests
    {
        Mock<CaffContext> _contextMock;
        Mock<CurrentUser> _currentUserMock;
        ICaffCommentManager _caffCommentManager;

        [SetUp]
        public void Setup()
        {
            _contextMock = new Mock<CaffContext>();
            _currentUserMock = new Mock<CurrentUser>();
            _caffCommentManager = new CaffCommentManager(_contextMock.Object, _currentUserMock.Object); 
        }
    }
}
