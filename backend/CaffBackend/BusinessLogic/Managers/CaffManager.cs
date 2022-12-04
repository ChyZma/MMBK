using BusinessLogic.Common;
using BusinessLogic.Services;
using DataAccess;
using DataAccess.Entities;
using Microsoft.AspNetCore.Http;

namespace BusinessLogic.Managers
{
    public class CaffManager : ICaffManager
    {
        private readonly CaffContext _context;
        private readonly ICurrentUser _currentUser;

        public CaffManager(CaffContext context, ICurrentUser currentUser)
        {
            _context = context;
            _currentUser = currentUser;
        }

        public void DeleteCaff(int id)
        {
            var caff = _context.CaffFiles
                .Where(c => c.UploaderId == _currentUser.Id || _currentUser.IsAdmin)
                .SingleOrDefault(c => c.Id == id);

            if (caff is null)
            {
                throw new UnauthorizedAccessException("You do not have permission to delete this caff");
            }

            if (caff.Enabled == false)
            {
                throw new InvalidOperationException("This caff is already deleted");
            }

            caff.Enabled = false;
            _context.SaveChanges();
        }

        public CaffFile GetCaff(int id)
        {
            var caff = _context.CaffFiles
                .Where(c => c.UploaderId == _currentUser.Id || _currentUser.IsAdmin)
                .SingleOrDefault(c => c.Id == id);

            if (caff is null)
            {
                throw new UnauthorizedAccessException("You do not have permission to delete this caff");
            }

            return caff;
        }

        public byte[] GetCaffPreview(int id)
        {
            var result = _context.CaffFiles
                .Where(c => c.Enabled || _currentUser.IsAdmin)
                .Select(c => new { c.Id, c.Preview })
                .SingleOrDefault(c => c.Id == id);

            if (result is null)
            {
                throw new InvalidOperationException("Caff is deleted!");
            }

            return result.Preview;
        }

        public IQueryable<CaffFile> ListCaffs()
        {
            return _context.CaffFiles.Where(c => c.Enabled || _currentUser.IsAdmin);
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
