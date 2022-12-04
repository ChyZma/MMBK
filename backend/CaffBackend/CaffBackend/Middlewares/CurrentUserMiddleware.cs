using BusinessLogic.Common;
using System.Security.Claims;

namespace CaffBackend.Middlewares
{
    public class CurrentUserMiddleware
    {
        private readonly RequestDelegate _next;

        public CurrentUserMiddleware(RequestDelegate next)
        {
            _next = next;
        }

        public async Task InvokeAsync(HttpContext context, ICurrentUser currentUser)
        {
            var request = context.Request;
            var user = context.User;
            if (user.Identity is not null && user.Identity.IsAuthenticated)
            {
                currentUser.SetUser(user);
            }

            await _next(context);
        }
    }
}
