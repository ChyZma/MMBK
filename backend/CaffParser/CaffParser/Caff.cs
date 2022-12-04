using System.Runtime.InteropServices;

namespace CaffParser
{
    public class Caff
    {
        [DllImport("parser.dll")]
        private static extern IntPtr Caff_Create(string path);
        [DllImport("parser.dll")]
        private static extern UInt16 Caff_Loadfile(IntPtr c);
        [DllImport("parser.dll")]
        private static extern UInt16 Caff_Parse(IntPtr c);

        public void Test()
        {
            IntPtr Caff = Caff_Create("../../../parser/assets/parser/1.caff");
            Console.WriteLine(Caff_Loadfile(Caff));
            Console.WriteLine(Caff_Parse(Caff));

        }
    }
}