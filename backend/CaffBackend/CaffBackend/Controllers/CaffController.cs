using BusinessLogic.Managers;
using CaffBackend.Requests;
using CaffBackend.Responses;
using DataAccess.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.IO.Compression;

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
        public IActionResult UploadCaff([FromForm] CaffUploadRequest request)
        {
            try
            {
                using (var memoryStream = new MemoryStream())
                {
                    request.File.CopyTo(memoryStream);
                    var file = new CaffFile
                    {
                        FileContent = memoryStream.ToArray(),
                        FileName = request.File.FileName,
                    };

                    _caffManager.UploadCaff(file);
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
                var result = _caffManager.ListCaffs();
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

