using System;

namespace cLib
{
    public class SharpSepia
    {
        /// <summary>
        /// Funkcja biblioteki w języku wysokiego poziomu c# dodająca do pikseli obrazu efekt sepii.
        /// </summary>
        /// <param name="tab">Tablica bajtów zawierająca wartości składowych RGB</param>
        /// <param name="pierwszy">Indeks pierwszego bajtu</param>
        /// <param name="ostatni">Indeks ostatniego bajtu</param>
        /// <param name="sepia">Wartość sepii</param>
        public static void ConvertToSepia(Byte[] tab, int pierwszy, int ostatni, int sepia)
        {
            for (int i = pierwszy; i <= ostatni - 4; i += 4)
            {
                //wyliczenie średniej wartości koloru piksela ze składowych RGB
                int sr = tab[i];   //blue
                sr += tab[i + 1];  //green
                sr += tab[i + 2];  //red
                sr /= 3;

                tab[i] = (byte)sr;                          //nowa wartość składowej blue

                if ((sr + sepia) > 255)                     //nowa wartość składowej green
                    tab[i + 1] = 255;
                else
                    tab[i + 1] = (byte)(sr + sepia);

                if ((sr + 2 * sepia) > 255)                 //nowa wartość składowej red
                    tab[i + 2] = 255;
                else
                    tab[i + 2] = (byte)(sr + 2 * sepia);
            }
        }
    }
}
