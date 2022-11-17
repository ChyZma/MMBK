using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogic.Managers
{
    public class CaffManager : ICaffManager
    {
        private readonly CaffContext _context;

        public CaffManager(CaffContext context)
        {
            _context = context;
        }

        
    }
}
