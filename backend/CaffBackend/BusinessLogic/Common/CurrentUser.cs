using DataAccess;
using DataAccess.Constants;
using DataAccess.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogic.Common
{
    public class CurrentUser : ICurrentUser
    {
        private readonly CaffContext _context;
        private readonly UserManager<User> _userManager;

        public CurrentUser(CaffContext context, UserManager<User> userManager)
        {
            _context = context;
            _userManager = userManager;
        }

        public bool IsAdmin { get; set; }
        public string Id { get; set; }

        public void SetUser(ClaimsPrincipal user)
        {
            IsAdmin = user.IsInRole(UserRoleConstants.Admin);
            Id = _userManager.GetUserId(user);
        }
    }
}
