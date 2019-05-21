using System;
using System.Runtime.InteropServices;

namespace SepiaConverter
{
	public class AsmDllImport
    {
		[DllImport("asmLib.dll", CallingConvention = CallingConvention.StdCall)]

		private static extern void Konwerter(Byte[] tab, int begin, int end, int sepia);

		/// <summary>
		/// Funkcja konwertująca tablicę bajtów do sepii.
		/// </summary>
		/// <param name="tab">Adres pierwszego elementu tablicy</param>
		/// <param name="begin">Indeks pierwszego elementu tablicy</param>
		/// <param name="end">Indeks ostatniego elementu tablicy</param>
		/// <param name="sepia">Współczynnik sepii</param>
		static public void ConvertToSepia(Byte[] tab, int begin, int end, int sepia)
		{
            Konwerter(tab, begin, end, sepia);
		}
	}
}