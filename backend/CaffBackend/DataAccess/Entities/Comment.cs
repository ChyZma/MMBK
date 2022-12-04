using System.ComponentModel.DataAnnotations;

namespace DataAccess.Entities
{
    public class Comment
    {
        public int Id { get; set; }
        [MaxLength(2048)]
        public string CommentText { get; set; }
        public int CaffFileId { get; set; }
        public string CommenterId { get; set; }
        
        public CaffFile CaffFile { get; internal set; }
        public User Commenter { get; set; }
    }
}