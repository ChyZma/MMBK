using BusinessLogic.Common;
using BusinessLogic.Managers;
using DataAccess;
using DataAccess.Entities;
using Microsoft.EntityFrameworkCore;
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
        Mock<ICurrentUser> _currentUserMock;
        ICaffCommentManager _caffCommentManager;

        [SetUp]
        public void Setup()
        {
            MockDbContext();
            _currentUserMock = new Mock<ICurrentUser>();

            _currentUserMock = new Mock<ICurrentUser>();
            _currentUserMock.Setup(c => c.Id).Returns("1");
            _currentUserMock.Setup(c => c.IsAdmin).Returns(false);

            _caffCommentManager = new CaffCommentManager(_contextMock.Object, _currentUserMock.Object);
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

            var comment = new Comment
            {
                Id = 1,
                CommenterId = "1",
                Commenter = user,
                CaffFileId = 1,
                CaffFile = caff,
                CommentText = "test",
            };

            var comments = new List<Comment> { comment }.AsQueryable();

            var commentMockSet = new Mock<DbSet<Comment>>();
            commentMockSet.As<IQueryable<Comment>>().Setup(m => m.Provider).Returns(comments.Provider);
            commentMockSet.As<IQueryable<Comment>>().Setup(m => m.Expression).Returns(comments.Expression);
            commentMockSet.As<IQueryable<Comment>>().Setup(m => m.ElementType).Returns(comments.ElementType);
            commentMockSet.As<IQueryable<Comment>>().Setup(m => m.GetEnumerator()).Returns(() => comments.GetEnumerator());

            _contextMock.Setup(c => c.Comments).Returns(commentMockSet.Object);

        }

        [Test]
        public void AddCommentToCaffWithInvalidIdShouldThrowException()
        {
            Assert.Throws<InvalidOperationException>(() => _caffCommentManager.AddComment(2, "test"));
        }

        [Test]
        public void AddCommentToCaffWithValidIdShouldAddComment()
        {
            _currentUserMock.Setup(c => c.Id).Returns("1");
            _caffCommentManager.AddComment(1, "test");
            _contextMock.Verify(c => c.SaveChanges(), Times.Once);
        }

        [Test]
        public void DeleteCommentWithInvalidIdShouldThrowException()
        {
            Assert.Throws<UnauthorizedAccessException>(() => _caffCommentManager.DeleteComment(-10));
        }

        [Test]
        public void DeleteCommentWithValidIdShouldDeleteComment()
        {
            var comment = new Comment
            {
                Id = 1,
                CommenterId = "1",
                CommentText = "test",
                CaffFileId = 1,
            };

            var comments = new List<Comment> { comment }.AsQueryable();

            var mockSet = new Mock<DbSet<Comment>>();
            mockSet.As<IQueryable<Comment>>().Setup(m => m.Provider).Returns(comments.Provider);
            mockSet.As<IQueryable<Comment>>().Setup(m => m.Expression).Returns(comments.Expression);
            mockSet.As<IQueryable<Comment>>().Setup(m => m.ElementType).Returns(comments.ElementType);
            mockSet.As<IQueryable<Comment>>().Setup(m => m.GetEnumerator()).Returns(() => comments.GetEnumerator());

            _contextMock.Setup(c => c.Comments).Returns(mockSet.Object);

            _caffCommentManager.DeleteComment(1);
            _contextMock.Verify(c => c.SaveChanges(), Times.Once);
        }

        [Test]
        public void DeleteCommentWhenUserIsNotCommenterOrAdminShouldThrowException()
        {
            var comment = new Comment
            {
                Id = 1,
                CommenterId = "2",
                CommentText = "test",
                CaffFileId = 1,
            };

            var comments = new List<Comment> { comment }.AsQueryable();

            var mockSet = new Mock<DbSet<Comment>>();
            mockSet.As<IQueryable<Comment>>().Setup(m => m.Provider).Returns(comments.Provider);
            mockSet.As<IQueryable<Comment>>().Setup(m => m.Expression).Returns(comments.Expression);
            mockSet.As<IQueryable<Comment>>().Setup(m => m.ElementType).Returns(comments.ElementType);
            mockSet.As<IQueryable<Comment>>().Setup(m => m.GetEnumerator()).Returns(() => comments.GetEnumerator());

            _contextMock.Setup(c => c.Comments).Returns(mockSet.Object);

            Assert.Throws<UnauthorizedAccessException>(() => _caffCommentManager.DeleteComment(1));
        }

        [Test]
        public void GetCommentsOfCaffWithNoCommentsShouldReturnEmptyList()
        {
            var result = _caffCommentManager.GetCommentsOfCaff(-10);
            Assert.That(0 == result.Count());

        }

        [Test]
        public void GetCommentsOfCaffWithValidIdShouldReturnComments()
        {
            var result = _caffCommentManager.GetCommentsOfCaff(1);
            Assert.That(1 == result.Count());
        }


    }
}
