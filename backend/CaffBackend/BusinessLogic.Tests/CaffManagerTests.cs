using BusinessLogic.Common;
using BusinessLogic.Managers;
using DataAccess;
using DataAccess.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Moq;
using Moq.EntityFrameworkCore;
using System.Reflection.Metadata;

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
            MockDbContext();

            _currentUserMock = new Mock<ICurrentUser>();
            _currentUserMock.Setup(c => c.Id).Returns("1");
            _currentUserMock.Setup(c => c.IsAdmin).Returns(false);
            _caffManager = new CaffManager(_contextMock.Object, _currentUserMock.Object);
        }

        private void MockDbContext()
        {
            _contextMock = new Mock<CaffContext>(new DbContextOptionsBuilder<CaffContext>().Options);

            var user = new User
            {
                Id = "1",
                UserName = "testuser",
                Email = ""
            };

            var caff = new CaffFile
            {
                Id = 1,
                FileName = "test",
                UploaderId = "1",
                Uploader = user,
                Tags = new List<Tag>(),
                Comments = new List<Comment>(),
                FileContent = new byte[0],
                Preview = new byte[0],
                Enabled = true,
            };

            var caffs = new List<CaffFile> { caff }.AsQueryable();

            var mockSet = new Mock<DbSet<CaffFile>>();
            mockSet.As<IQueryable<CaffFile>>().Setup(m => m.Provider).Returns(caffs.Provider);
            mockSet.As<IQueryable<CaffFile>>().Setup(m => m.Expression).Returns(caffs.Expression);
            mockSet.As<IQueryable<CaffFile>>().Setup(m => m.ElementType).Returns(caffs.ElementType);
            mockSet.As<IQueryable<CaffFile>>().Setup(m => m.GetEnumerator()).Returns(() => caffs.GetEnumerator());

            _contextMock.Setup(c => c.CaffFiles).Returns(mockSet.Object);
        }

        [Test]
        public void DeleteCaffShouldCallCurrentUserId()
        {
            //Act
            _caffManager.DeleteCaff(1);

            //Assert
            _currentUserMock.Verify(c => c.Id, Times.AtLeastOnce);
        }

        [Test]
        public void DeleteCaffShouldCallContextCaffFiles()
        {
            //Act
            _caffManager.DeleteCaff(1);

            //Assert
            _contextMock.Verify(c => c.CaffFiles, Times.AtLeastOnce);
        }

        [Test]
        public void DeleteCaffShouldCallContextSaveChanges()
        {
            //Act
            _caffManager.DeleteCaff(1);

            //Assert
            _contextMock.Verify(c => c.SaveChanges(), Times.AtLeastOnce);
        }

        [Test]
        public void DeleteCaffShouldSetValidCaffToDisabled()
        {
            //Arrange
            var caff = new CaffFile
            {
                Id = 1,
                UploaderId = "1",
                Enabled = true
            };
            _contextMock.Setup(c => c.CaffFiles).ReturnsDbSet(new List<CaffFile> { caff });

            //Act
            _caffManager.DeleteCaff(1);

            //Assert
            Assert.IsFalse(caff.Enabled);
        }

        [Test]
        public void DeleteCaffShouldThrowExceptionWhenCaffIsAlreadyDisabled()
        {
            //Arrange
            var caff = new CaffFile
            {
                Id = 1,
                UploaderId = "1",
                Enabled = false
            };
            _contextMock.Setup(c => c.CaffFiles).ReturnsDbSet(new List<CaffFile> { caff });

            //Act
            Assert.Throws<InvalidOperationException>(() => _caffManager.DeleteCaff(1));
        }

        [Test]
        public void DeleteCaffShouldThrowExceptionWhenCaffIsNotOwnedByCurrentUser()
        {
            //Arrange
            var caff = new CaffFile
            {
                Id = 1,
                UploaderId = "2",
                Enabled = true
            };
            _contextMock.Setup(c => c.CaffFiles).ReturnsDbSet(new List<CaffFile> { caff });

            //Act
            Assert.Throws<UnauthorizedAccessException>(() => _caffManager.DeleteCaff(1));
        }

        [Test]
        public void GetCaffShouldCallCurrentUserId()
        {
            //Act
            _caffManager.GetCaff(1);

            //Assert
            _currentUserMock.Verify(c => c.Id, Times.AtLeastOnce);
        }

        [Test]
        public void GetCaffShouldCallContextCaffFiles()
        {
            //Act
            _caffManager.GetCaff(1);

            //Assert
            _contextMock.Verify(c => c.CaffFiles, Times.AtLeastOnce);
        }

        [Test]
        public void GetCaffShouldReturnValidCaff()
        {
            //Arrange
            var caff = new CaffFile
            {
                Id = 1,
                UploaderId = "1",
                Enabled = true
            };
            _contextMock.Setup(c => c.CaffFiles).ReturnsDbSet(new List<CaffFile> { caff });

            //Act
            var result = _caffManager.GetCaff(1);

            //Assert
            Assert.That(caff, Is.EqualTo(result));
        }

        [Test]
        public void GetCaffShouldThrowExceptionWhenCaffIsNotOwnedByCurrentUser()
        {
            //Arrange
            var caff = new CaffFile
            {
                Id = 1,
                UploaderId = "2",
                Enabled = true,
                Owners = new List<User> { new User { Id = "3" } }
            };
            _contextMock.Setup(c => c.CaffFiles).ReturnsDbSet(new List<CaffFile> { caff });

            //Act
            Assert.Throws<UnauthorizedAccessException>(() => _caffManager.GetCaff(1));
        }

        [Test]
        public void GetCaffPreviewShouldCallContextCaffFiles()
        {
            //Act
            _caffManager.GetCaffPreview(1);

            //Assert
            _contextMock.Verify(c => c.CaffFiles, Times.AtLeastOnce);
        }

        [Test]
        public void GetCaffPreviewShouldReturnValidCaffPreview()
        {
            //Arrange
            var caff = new CaffFile
            {
                Id = 1,
                UploaderId = "1",
                Enabled = true,
                Preview = new byte[] { 1, 2, 3 }
            };
            _contextMock.Setup(c => c.CaffFiles).ReturnsDbSet(new List<CaffFile> { caff });

            //Act
            var result = _caffManager.GetCaffPreview(1);

            //Assert
            Assert.That(caff.Preview, Is.EqualTo(result));
        }

        [Test]
        public void GetCaffPreviewShouldThrowExceptionWhenCaffIsNotEnabled()
        {
            //Arrange
            var caff = new CaffFile
            {
                Id = 1,
                UploaderId = "1",
                Enabled = false,
                Preview = new byte[] { 1, 2, 3 }
            };
            _contextMock.Setup(c => c.CaffFiles).ReturnsDbSet(new List<CaffFile> { caff });

            //Act
            Assert.Throws<InvalidOperationException>(() => _caffManager.GetCaffPreview(1));
        }

        [Test]
        public void ListCaffShouldReturnEnabledCaffsWhenUserIsNotAdmin()
        {
            //Arrange
            var caff1 = new CaffFile
            {
                Id = 1,
                UploaderId = "1",
                Enabled = true
            };
            var caff2 = new CaffFile
            {
                Id = 2,
                UploaderId = "1",
                Enabled = false
            };
            _contextMock.Setup(c => c.CaffFiles).ReturnsDbSet(new List<CaffFile> { caff1, caff2 });

            //Act
            var result = _caffManager.ListCaffs().ToList();

            //Assert
            Assert.That(result, Has.Exactly(1).Items);
            Assert.That(result, Has.Exactly(1).Matches<CaffFile>(c => c.Id == 1));
        }

        [Test]
        public void ListCaffShouldReturnAllCaffsWhenUserIsAdmin()
        {
            //Arrange
            var caff1 = new CaffFile
            {
                Id = 1,
                UploaderId = "1",
                Enabled = true
            };
            var caff2 = new CaffFile
            {
                Id = 2,
                UploaderId = "1",
                Enabled = false
            };
            _contextMock.Setup(c => c.CaffFiles).ReturnsDbSet(new List<CaffFile> { caff1, caff2 });
            _currentUserMock.Setup(c => c.IsAdmin).Returns(true);

            //Act
            var result = _caffManager.ListCaffs().ToList();

            //Assert
            Assert.That(result, Has.Exactly(2).Items);
            Assert.That(result, Has.Exactly(1).Matches<CaffFile>(c => c.Id == 1));
            Assert.That(result, Has.Exactly(1).Matches<CaffFile>(c => c.Id == 2));
        }

        [Test]
        public void UploadShouldThrowExceptionWhenFileContentIsNull()
        {
            //Arrange
            var caff = new CaffFile
            {
                Id = 1,
                UploaderId = "1",
                Enabled = true
            };
            _contextMock.Setup(c => c.CaffFiles).ReturnsDbSet(new List<CaffFile> { caff });

            //Act
            Assert.Throws<InvalidOperationException>(() => _caffManager.UploadCaff(new CaffFile()));
        }
        

        [Test]
        public void UploadCaffShouldCallContextSaveChangesAndContextCaffFiles()
        {
            //Arrange
            var caff = new CaffFile
            {
                Id = 1,
                UploaderId = "1",
                Enabled = true,
                FileContent = File.ReadAllBytes("1.caff"),
            };
            _contextMock.Setup(c => c.CaffFiles).ReturnsDbSet(new List<CaffFile> { });

            //Act
            _caffManager.UploadCaff(caff);

            //Assert
            _contextMock.Verify(c => c.SaveChanges(), Times.AtLeastOnce);
            _contextMock.Verify(c => c.CaffFiles, Times.AtLeastOnce);
        }

    }
}
