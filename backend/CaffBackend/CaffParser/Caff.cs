using System.Runtime.InteropServices;
using System.Text;

namespace CaffParser
{
    public struct CaffCredits
    {
        public UInt32 Year { get; }
        public UInt16 Month { get; }
        public UInt16 Day { get; }
        public UInt16 Hour { get;  }
        public UInt16 Minute { get; }
        public string Creator { get; }

        public CaffCredits(uint year, ushort month, ushort day, ushort hour, ushort minute, string creator)
        {
            Year = year;
            Month = month;
            Day = day;
            Hour = hour;
            Minute = minute;
            Creator = creator;
        }
    }
    public class Caff
    {
        private readonly IntPtr _caff;
        private readonly string _path;

        public CaffCredits Credits;

        public string Caption { get; }
        public List<string> Tags { get; }

        [DllImport("parser")]
        private static extern IntPtr Caff_Create(string path);

        [DllImport("parser")]
        private static extern UInt16 Caff_Loadfile(IntPtr c);

        [DllImport("parser")]
        private static extern UInt16 Caff_Parse(IntPtr c);

        [DllImport("parser")]
        private static extern UInt32 Caff_GetCreditsYear(IntPtr c);

        [DllImport("parser")]
        private static extern UInt16 Caff_GetCreditsMonth(IntPtr c);

        [DllImport("parser")]
        private static extern UInt16 Caff_GetCreditsDay(IntPtr c);

        [DllImport("parser")]
        private static extern UInt16 Caff_GetCreditsHour(IntPtr c);

        [DllImport("parser")]
        private static extern UInt16 Caff_GetCreditsMinute(IntPtr c);

        [DllImport("parser")]
        private static extern void __Caff_GetCreditsCreator__(IntPtr c, StringBuilder str);

        private string Caff_GetCreditsCreator(IntPtr c)
        {
            StringBuilder str = new StringBuilder(1024);

            __Caff_GetCreditsCreator__(c, str);
            return str.ToString();
        }

        [DllImport("parser")]
        private static extern void __Caff_GetCaption__(IntPtr c, StringBuilder str);

        private string Caff_GetCaption(IntPtr c)
        {
            StringBuilder str = new StringBuilder(2048);

            __Caff_GetCaption__(c, str);
            return str.ToString();
        }

        [DllImport("parser")]
        private static extern void __Caff_GetTagsString__(IntPtr c, StringBuilder str);

        private List<string> Caff_GetTags(IntPtr c)
        {
            StringBuilder str = new StringBuilder(2048);

            __Caff_GetTagsString__(c, str);
            string res_string = str.ToString().Trim();

            return new List<string>(res_string.Split(','));
        }

        [DllImport("parser")]
        private static extern UInt16 __Caff_GenerateGif__(IntPtr c, string path);

        public void GenerateGif(string path)
        {
            UInt16 result = __Caff_GenerateGif__(_caff, path);
            if (result != 0)
            {
                throw new Exception($"Something went wrong durin GIF generation: {result}");
            }
        }

        public Caff(string path)
        {

            _path = path;
            _caff = Caff_Create(_path);
            if (Caff_Loadfile(_caff) != 0)
            {
                throw new FileNotFoundException($"Caff file not found at: {_path}");
            }

            var parseResult = Caff_Parse(_caff);
            if (parseResult != 0)
            {
                throw new InvalidDataException($"Caff parse failed with: {parseResult}");
            }

            Credits = new CaffCredits(Caff_GetCreditsYear(_caff),
                                      Caff_GetCreditsMonth(_caff),
                                      Caff_GetCreditsDay(_caff),
                                      Caff_GetCreditsHour(_caff),
                                      Caff_GetCreditsMinute(_caff),
                                      Caff_GetCreditsCreator(_caff));
            Caption = Caff_GetCaption(_caff);

            Tags = Caff_GetTags(_caff);
        }
    }
}