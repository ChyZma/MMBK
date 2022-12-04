using BusinessLogic.Common;
using DataAccess;
using DataAccess.Entities;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogic.Managers
{
    public class CaffCommentManager : ICaffCommentManager
    {
        private readonly CaffContext _context;
        private readonly ICurrentUser _currentUser;

        public CaffCommentManager(CaffContext context, ICurrentUser currentUser)
        {
            _context = context;
            _currentUser = currentUser;
        }

        public void AddComment(int id, string comment)
        {
            var caff = _context.CaffFiles
                .Where(c => c.Enabled || _currentUser.IsAdmin)
                .SingleOrDefault(c => c.Id == id);

            if (caff is null)
            {
                throw new InvalidOperationException("Caff not found");
            }

            var caffComment = new Comment
            {
                CaffFileId = id,
                CommenterId = _currentUser.Id,
                CommentText = comment,
            };

            _context.Comments.Add(caffComment);
            _context.SaveChanges();
        }

        public void DeleteComment(int id)
        {
            var comment = _context.Comments
                .Where(c => c.CommenterId == _currentUser.Id || _currentUser.IsAdmin)
                .SingleOrDefault(c => c.Id == id);

            if (comment is null)
            {
                throw new UnauthorizedAccessException("You do not have permission to delete this comment");
            }

            _context.Comments.Remove(comment);
            _context.SaveChanges();
        }

        public IQueryable<Comment> GetCommentsOfCaff(int id)
        {
            var comments = _context.Comments
                .Where(c => c.CaffFileId == id)
                .Where(c => c.CaffFile.Enabled || _currentUser.IsAdmin);

            return comments;
        }
    }
}
