using DataAccess.Enums;

namespace DataAccess.Entities
{
    public class CaffFile
    {
        public int Id { get; set; }
        public byte[] FileContent { get; set; }
        public byte[] Preview { get; set; }
        public string FileName { get; set; }
        public double Price { get; set; } = 0;
        public Currency Currency { get; set; } = Currency.HUF;
        public string UploaderId { get; set; }

        public List<Comment> Comments { get; set; }
        public List<Tag> Tags { get; set; }
        public User Uploader { get; set; }
    }
}