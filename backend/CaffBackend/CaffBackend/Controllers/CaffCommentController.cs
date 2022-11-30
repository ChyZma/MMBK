using BusinessLogic.Managers;
using CaffBackend.Responses;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace CaffBackend.Controllers
{
    [Route("api/caff")]
    [ApiController]
    public class CaffCommentController : ControllerBase
    {
        private readonly ICaffCommentManager _commentManager;

        public CaffCommentController(ICaffCommentManager commentManager)
        {
            _commentManager = commentManager;
        }

        [HttpPost("{id}/comment")]
        public IActionResult AddComment(int id, [FromBody] string comment)
        {
            //_commentManager.AddComment(id, comment);
            return Ok();
        }

        [HttpDelete("{id}/comment/{commentId}")]
        public IActionResult DeleteComment(int id, int commentId)
        {
            //_commentManager.DeleteComment(id);
            return Ok();
        }

        [HttpGet("{id}/comment")]
        public ActionResult<List<CaffCommentResponse>> GetComments(int id)
        {
            //_commentManager.GetComments(id);
            return Ok();
        }
    }
}
