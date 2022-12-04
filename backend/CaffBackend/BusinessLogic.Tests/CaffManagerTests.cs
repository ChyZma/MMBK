using BusinessLogic.Common;
using BusinessLogic.Managers;
using DataAccess;
using DataAccess.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Moq;
using Moq.EntityFrameworkCore;

namespace BusinessLogic.Tests
{
    public class CaffManagerTests
    {
        Mock<CaffContext> _contextMock;
        Mock<ICurrentUser> _currentUserMock;
        ICaffManager _caffManager;

        [SetUp]
        public void Setup()
        {
            
        }

        [Test]
        public void DeleteCaffShouldCallCurrentUserIdOrIsAdmin()
        {
        }

        [Test]
        public void DeleteCaffShouldCallContextCaffFiles()
        {
            
        }

        [Test]
        public void DeleteCaffShouldCallContextSaveChanges()
        {
            
        }

        [Test]
        public void DeleteCaffShouldSetValidCaffToDisabled()
        {
            
        }

        [Test]
        public void DeleteCaffShouldThrowExceptionWhenCaffIsAlreadyDisabled()
        {
            
        }

        [Test]
        public void DeleteCaffShouldThrowExceptionWhenCaffIsNotOwnedByCurrentUser()
        {
            
        }

        [Test]
        public void GetCaffShouldCallCurrentUserIdOrIsAdmin()
        {
            
        }

        [Test]
        public void GetCaffShouldCallContextCaffFiles()
        {
            
        }

        [Test]
        public void GetCaffShouldReturnValidCaff()
        {
            
        }

        [Test]
        public void GetCaffShouldThrowExceptionWhenCaffIsNotOwnedByCurrentUser()
        {
            
        }

        [Test]
        public void GetCaffPreviewShouldCallContextCaffFiles()
        {
            
        }

        [Test]
        public void GetCaffPreviewShouldReturnValidCaffPreview()
        {
            
        }

        [Test]
        public void GetCaffPreviewShouldThrowExceptionWhenCaffIsNotEnabled()
        {

            
        }

        [Test]
        public void ListCaffShouldReturnEnabledCaffsWhenUserIsNotAdmin()
        {
            
        }

        [Test]
        public void ListCaffShouldReturnAllCaffsWhenUserIsAdmin()
        {
            
        }

        [Test]
        public void UploadCaffShouldCallContextCaffFiles()
        {
            
        }

        [Test]
        public void UploadCaffShouldCallContextSaveChanges()
        {
            
        }

    }
}
