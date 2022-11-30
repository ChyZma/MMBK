using BusinessLogic.Managers;
using CaffBackend.Requests;
using CaffBackend.Responses;
using Microsoft.AspNetCore.Mvc;

namespace CaffBackend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CaffController : ControllerBase
    {
        private readonly ICaffManager _caffManager;

        public CaffController(ICaffManager caffManager)
        {
            _caffManager = caffManager;
        }

        [HttpPost]
        public IActionResult UploadCaff(CaffUploadRequest request) 
        {
            return Ok();
        }

        [HttpGet("{id}")]
        public FileContentResult DownloadCaff(int id)
        {
            byte[] bytes = { };
            return File(bytes, "");
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteCaff(int id)
        {
            return Ok();
        }

        [HttpGet]
        public ActionResult<List<CaffResponse>> ListCaffs()
        {
            return Ok();
        }

        [HttpGet("{id}/preview")]
        public FileContentResult PreviewCaff(int id)
        {
            byte[] bytes = { };
            return File(bytes, "");
        }

    }
}
