namespace CaffBackend.Responses
{
    public class CaffCommentResponse
    {
        public int Id { get; set; }
        public string Comment { get; set; } = string.Empty;
        public string UserName { get; set; } = string.Empty;
    }
}
