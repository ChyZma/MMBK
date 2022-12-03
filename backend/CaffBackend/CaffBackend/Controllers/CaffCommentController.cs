using BusinessLogic.Managers;
using CaffBackend.Responses;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace CaffBackend.Controllers
{
    [Route("api/caff")]
    [ApiController]
    [Authorize]
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
            try
            {
                _commentManager.AddComment(id, comment);
                return Ok();
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpDelete("{id}/comment/{commentId}")]
        public IActionResult DeleteComment(int id, int commentId)
        {
            try
            {
                _commentManager.DeleteComment(id);
                return Ok();
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpGet("{id}/comment")]
        public ActionResult<List<CaffCommentResponse>> GetComments(int id)
        {
            try
            {
                var result = _commentManager
                    .GetCommentsOfCaff(id)
                    .Select(c => new CaffCommentResponse
                    {
                        Id = c.Id,
                        Comment = c.CommentText,
                        UserName = c.Commenter.UserName,

                    });

                return Ok(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
    }
}
