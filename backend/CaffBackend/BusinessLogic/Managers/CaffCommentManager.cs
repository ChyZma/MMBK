using DataAccess;
using DataAccess.Entities;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogic.Managers
{
    public class CaffCommentManager : ICaffCommentManager
    {
        private readonly CaffContext _context;

        public CaffCommentManager(CaffContext context)
        {
            _context = context;
        }
    }
}
