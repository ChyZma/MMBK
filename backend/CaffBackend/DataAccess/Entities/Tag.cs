namespace DataAccess.Entities
{
    public class Tag
    {
        public int Id { get; set; }
        public string TagText { get; set; }
        public int CaffFileId { get; set; }
        
        public CaffFile CaffFile { get; set; }
    }
}