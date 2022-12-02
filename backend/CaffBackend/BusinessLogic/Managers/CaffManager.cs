using BusinessLogic.Services;
using DataAccess;
using DataAccess.Entities;
using Microsoft.AspNetCore.Http;

namespace BusinessLogic.Managers
{
    public class CaffManager : ICaffManager
    {
        private readonly CaffContext _context;
        private readonly IHttpContextAccessor _contextAccessor;

        //TODO: Inject the current user
        public CaffManager(CaffContext context, IHttpContextAccessor contextAccessor)
        {
            _context = context;
            _contextAccessor = contextAccessor;
        }

        public void DeleteCaff(int id)
        {
            var asd = _contextAccessor.HttpContext.User;
            //TODO: user can only delete his own caffs or Admin
            var caff = _context.CaffFiles.Single(c => c.Id == id);
            
            caff.Enabled = false;
            _context.SaveChanges();
        }

        public CaffFile GetCaff(int id)
        {
            //TODO: user can only download his own caffs or Admin
            var caff = _context.CaffFiles.Single(c => c.Id == id);
            return caff;
        }

        public byte[] GetCaffPreview(int id)
        {
            //TODO: if not enabled throw error
            var result = _context.CaffFiles.Select(c => new { c.Id, c.Preview }).Single(c => c.Id == id);
            return result.Preview;
        }

        public IQueryable<CaffFile> ListCaffs()
        {
            return _context.CaffFiles.Where(c => c.Enabled);
        }

        public void UploadCaff(CaffFile caffFile)
        {
            //TODO: CALL PARSER HERE
            var dummyTags = new List<Tag>
            {
                new Tag { TagText = "dummy" },
                new Tag { TagText = "dummy2" },
            };
            caffFile.Tags = dummyTags;
            //read example gif from disk
            var preview = File.ReadAllBytes(@"example.gif");
            caffFile.Preview = preview;
            caffFile.UploaderId = _context.Users.First().Id;
            _context.CaffFiles.Add(caffFile);
            _context.SaveChanges();
        }
    }
}
