using BusinessLogic.Managers;
using CaffBackend.Requests;
using CaffBackend.Responses;
using DataAccess.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.IO.Compression;
using System.Net;

namespace CaffBackend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class CaffController : ControllerBase
    {
        private readonly ICaffManager _caffManager;

        public CaffController(ICaffManager caffManager)
        {
            _caffManager = caffManager;
        }

        [HttpPost]
        public IActionResult UploadCaff(IFormFile file)
        {
            try
            {
                using (var memoryStream = new MemoryStream())
                {
                    file.CopyTo(memoryStream);
                    var f = new CaffFile
                    {
                        FileContent = memoryStream.ToArray(),
                        FileName = file.FileName,
                    };

                    _caffManager.UploadCaff(f);
                    return Ok();
                }
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpGet("{id}")]
        public IActionResult DownloadCaff(int id)
        {
            try
            {
                var file = _caffManager.GetCaff(id);
                return File(file.FileContent, "application/octet-stream", file.FileName);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteCaff(int id)
        {
            try
            {
                _caffManager.DeleteCaff(id);
                return Ok();
            }
            catch (UnauthorizedAccessException e)
            {
                return Unauthorized(e.Message);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpGet]
        public ActionResult<List<CaffResponse>> ListCaffs()
        {
            try
            {
                var result = _caffManager
                    .ListCaffs()
                    .Select(c => new CaffResponse
                    {
                        Id = c.Id,
                        FileName = c.FileName,
                        Tags = c.Tags.Select(t => t.TagText).ToList(),
                    });

                return Ok(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpGet("{id}/preview")]
        public IActionResult PreviewCaff(int id)
        {
            try
            {
                byte[] file = _caffManager.GetCaffPreview(id);
                return File(file, "image/gif");
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

    }
}

