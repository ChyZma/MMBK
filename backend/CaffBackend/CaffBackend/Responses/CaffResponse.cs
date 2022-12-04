namespace CaffBackend.Responses
{
    public class CaffResponse
    {
        public int Id { get; set; }
        public List<string> Tags { get; set; } = new List<string>();
        public string FileName { get; set; } = string.Empty;
    }
}
