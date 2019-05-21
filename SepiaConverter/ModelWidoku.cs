using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SepiaConverter
{
    /// <summary>
    /// Klasa zawierająca zmienne modelu widoku.
    /// </summary>
    public class ModelWidoku : ModelWidokuRodzic
	{
		private string sciezkaPliku;

		private string sciezkaZapisu;

		private bool czyAktywny;

		private bool konwertAktywny;

		private int sepia;

		private short iloscWatkow;

		/// <summary>
		/// Współczynnik sepii
		/// </summary>
		public int Sepia
		{
			get { return sepia; }
			set { SetProperty(ref sepia, value); }
		}

		/// <summary>
		/// Ilość wątków
		/// </summary>
		public short Watki
		{
			get { return iloscWatkow; }
			set { SetProperty(ref iloscWatkow, value); }
		}

		/// <summary>
		/// Ścieżka do obrazu
		/// </summary>
		public string SciezkaPliku
		{
			get { return sciezkaPliku; }
			set { SetProperty(ref sciezkaPliku, value); }
		}

		/// <summary>
		/// Ścieżka do zapisu
		/// </summary>
		public string DescPath
		{
			get { return sciezkaZapisu; }
			set { SetProperty(ref sciezkaZapisu, value); }
		}

		/// <summary>
		/// Asm radiobox
		/// </summary>
		public bool AsmOK { get; set; }

		/// <summary>
		/// C# radiobox
		/// </summary>
		public bool CsharpOK { get; set; }

		/// <summary>
		/// Dostępność buttonów
		/// </summary>
		public bool CzyAktywny
		{
			get { return czyAktywny; }
			set { SetProperty(ref czyAktywny, value); }
		}

		/// <summary>
		/// Dostępność buttona konwersji
		/// </summary>
		public bool KonwertAktywny
		{
			get { return konwertAktywny; }
			set { SetProperty(ref konwertAktywny, value); }
		}
	}
}
