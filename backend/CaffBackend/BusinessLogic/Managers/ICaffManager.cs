using DataAccess.Entities;

namespace BusinessLogic.Managers
{
    public interface ICaffManager
    {
        void DeleteCaff(int id);
        CaffFile GetCaff(int id);
        byte[] GetCaffPreview(int id);
        IQueryable<CaffFile> ListCaffs();
        void UploadCaff(CaffFile request);
    }
}