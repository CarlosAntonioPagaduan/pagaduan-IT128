using BlogDataLibrary.Data;
using BlogDataLibrary.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace BlogAPI.Controllers
{
    public class PostController : Controller
    {
        private ISqlData _db;
        public IActionResult Index()
        {
            return View();
        }
        public PostController(ISqlData db)
        {
            _db = db;
        }
        [AllowAnonymous]
        [HttpGet]
        [Route("/api/[controller]/listposts")]
        public ActionResult ListPosts()
        {
            List<ListPostModel> posts = _db.ListPosts();
            return Ok(posts);
        }
        [AllowAnonymous]
        [HttpGet]
        [Route("/api/[controller]/{id}")]
        public ActionResult ShowPOstDetails(int id)
        {
            ListPostModel post = _db.ShowPostDetails(id);
            return Ok(post);
        }
        private int GetCurrentUserId()
        {
            ClaimsIdentity identity = HttpContext.User.Identity as ClaimsIdentity;
            if (identity != null)
            {
                var userClaims = identity.Claims;
                string id = userClaims.FirstOrDefault(x => x.Type == ClaimTypes.NameIdentifier)?.Value;

                if (id != null)
                {
                    return Convert.ToInt32(id);
                }
            }
            return 0;
        }
        [Authorize]
        [HttpPost]
        [Route("/api/[controller]/add")]
        public ActionResult AddPost([FromBody] PostForm form)
        {
            PostModel post = new PostModel();
            post.Title = form.Title;
            post.Body = form.Body;
            post.DateCreated = DateTime.Now;
            post.UserId = GetCurrentUserId();
            _db.AddPost(post);

            return Ok("Post Created.");
        }
    }
}