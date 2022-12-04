using System.Runtime.InteropServices;

namespace CaffParser
{
    public class Caff
    {
        [DllImport("D:\\school stuff\\BME\\Számítógép-biztonság\\MMBK\\backend\\CaffBackend\\CaffParser\\parser.dll")]
        private static extern IntPtr Caff_Create(string path);
        [DllImport("D:\\school stuff\\BME\\Számítógép-biztonság\\MMBK\\backend\\CaffBackend\\CaffParser\\parser.dll")]
        private static extern UInt16 Caff_Loadfile(IntPtr c);
        [DllImport("D:\\school stuff\\BME\\Számítógép-biztonság\\MMBK\\backend\\CaffBackend\\CaffParser\\parser.dll")]
        private static extern UInt16 Caff_Parse(IntPtr c);

        public void Test()
        {
            IntPtr Caff = Caff_Create("D:\\school stuff\\BME\\Számítógép-biztonság\\MMBK\\backend\\CaffBackend\\CaffParser\\1.caff");
            Console.WriteLine(Caff_Loadfile(Caff));
            Console.WriteLine(Caff_Parse(Caff));

        }
    }
}