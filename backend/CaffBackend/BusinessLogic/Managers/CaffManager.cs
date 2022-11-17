using DataAccess;

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
