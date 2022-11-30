using Microsoft.AspNetCore.Identity;

namespace DataAccess.Entities
{
    public class User : IdentityUser
    {
        public List<CaffFile> UploadedCaffFiles { get; set; }
        public List<CaffFile> OwnedCaffFiles { get; set; }
        public List<Comment> Comments { get; set; }
    }
}
