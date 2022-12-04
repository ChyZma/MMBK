using BusinessLogic.Common;
using DataAccess;
using DataAccess.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Serilog;

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
                .Where(c => c.UploaderId == _currentUser.Id || _currentUser.IsAdmin || c.Owners.Any(o => o.Id == _currentUser.Id))
                .SingleOrDefault(c => c.Id == id);

            if (caff is null)
            {
                throw new UnauthorizedAccessException("You do not have permission to download this caff");
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
            // Ensure `tmp` directory exists
            if (!Directory.Exists("tmp"))
                Directory.CreateDirectory("tmp");

            // Parse file from temporary disk location
            var randomNumber = new Random().Next(100000, 999999);
            var now = DateTime.Now.ToString("yyyy-MM-dd-HH-mm-ss");
            var tempFileName = $"{now}_{randomNumber}";
            try
            {
                using var writer = new BinaryWriter(File.OpenWrite($"tmp/{tempFileName}.caff"));
                writer.Write(caffFile.FileContent);
                writer.Close();
                var caff = new CaffParser.Caff($"tmp/{tempFileName}.caff");
                File.Delete($"tmp/{tempFileName}.caff");
                // Create tags
                var tags = new List<Tag>();
                foreach (var tag in caff.Tags)
                {
                    tags.Add(new Tag { TagText = tag });
                }
                caffFile.Tags = tags;

                // Load gif from temporary disk location
                caff.GenerateGif($"tmp/{tempFileName}.gif");
                var preview = File.ReadAllBytes($"tmp/{tempFileName}.gif");
                caffFile.Preview = preview;
                File.Delete($"tmp/{tempFileName}.gif");
            }
            catch (Exception e)
            {
                Log.Error(e.Message);
                File.Delete($"tmp/{tempFileName}.caff");
                File.Delete($"tmp/{tempFileName}.gif");
                throw new InvalidOperationException("Invalid caff file!");
            }

            caffFile.UploaderId = _currentUser.Id;
            _context.CaffFiles.Add(caffFile);
            _context.SaveChanges();
        }
    }
}
