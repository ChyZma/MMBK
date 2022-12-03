using System.Security.Claims;

namespace BusinessLogic.Common
{
    public interface ICurrentUser
    {
        public bool IsAdmin { get; protected set; }
        public string Id { get; protected set; }

        public void SetUser(ClaimsPrincipal user);
    }
}