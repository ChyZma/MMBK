using Microsoft.AspNetCore.Identity;

namespace DataAccess.Entities
{
    public class User : IdentityUser
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }

        public List<CaffFile> UploadedCaffFiles { get; set; }
        public List<Comment> Comments { get; set; }
    }
}
