using DataAccess.Entities;

namespace BusinessLogic.Managers
{
    public interface ICaffCommentManager
    {
        void AddComment(int id, string comment);
        void DeleteComment(int id);
        IQueryable<Comment> GetCommentsOfCaff(int id);
    }
}