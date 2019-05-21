using System;
using System.Windows;
using System.Drawing;
using System.IO;
using System.Drawing.Imaging;
using System.Threading;
using System.Collections.Generic;
using Konwerter_C = cLib.SharpSepia;
using Konwerter_ASM = SepiaConverter.AsmDllImport;
using System.Diagnostics;

namespace SepiaConverter
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        // zmienna model sluzy do operowania na zmiennych wykorzystywanych w gui
        private ModelWidoku model;

        // zmienna przechowujaca bitmapę
        private Bitmap bmp;

        // rozszerzenia plików graficznych, które mogą być poddane konwersji
        private readonly string filtrRozszerzen = @"Plik obrazu (*.jpg, *.jpeg, *.bmp, *.png) |*.jpg; *.jpeg; *.bmp; *.png";

        /// <summary>
        /// Konstruktor głównego okna programu.
        /// </summary>
        public MainWindow()
		{
			InitializeComponent();
			model = new ModelWidoku();
            // przypisanie kontekstu (model widoku) obiektowi okna głównego
            this.DataContext = model;

			// wartości inicjalizacyjne zmiennych interfejsu użytkownika
			model.Watki = (short)Environment.ProcessorCount;
			model.AsmOK = true;
			model.CsharpOK = false;
			model.CzyAktywny = true;
			model.KonwertAktywny = false;
			model.Sepia = 30;
		}

		/// <summary>
		/// Zdarzenie wybierania ścieżki do pliku graficznego.
		/// </summary>
		private void SourceButton_OnClick(object sender, RoutedEventArgs e)
		{
			System.Windows.Forms.OpenFileDialog dlg = new System.Windows.Forms.OpenFileDialog
			{
				Title = @"Otwórz plik",
				Filter = filtrRozszerzen
			};

			if (dlg.ShowDialog() == System.Windows.Forms.DialogResult.OK)
			{
				if (File.Exists(dlg.FileName))
				{
					model.SciezkaPliku = dlg.FileName;
				}
				else
				{
                    MessageBox.Show("Podany plik nie istnieje.", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
				}
			}
			dlg.Dispose();
		}

		/// <summary>
		/// Zdarzenie ładowania obrazu z pliku do zmiennej przechowującej bitmapę.
		/// </summary>
		private void LoadButton_OnClick(object sender, RoutedEventArgs e)
		{
			bmp = null;
			img.Source = null;

			if (File.Exists(model.SciezkaPliku))
			{
				bmp = new Bitmap(model.SciezkaPliku);

				// konwersja formatu pikseli na 32argb w przypadku innego formatu tychże
				if (!bmp.PixelFormat.Equals(PixelFormat.Format32bppArgb))
				{
					bmp = Konwerter.ZmianaFormatuPikseli(bmp);
				}
				img.Source = Konwerter.KonwertujBitmapeNaObraz(bmp);
				model.KonwertAktywny = true;
			}
			else
			{
                MessageBox.Show("Nie wskazano pliku.", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
		}

		/// <summary>
		/// Zdarzenie zapisu przekonwertowanej grafiki do pliku.
		/// </summary>
		private void SaveButton_OnClick(object sender, RoutedEventArgs e)
		{
			if (bmp == null)
            {
                MessageBox.Show("Brak pliku do zapisu.", "ERROR", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
			}
			//instancja okna zapisu do pliku
			Microsoft.Win32.SaveFileDialog dlg = new Microsoft.Win32.SaveFileDialog();
			dlg.Filter = "(*.png)|*.png";
			var result = dlg.ShowDialog();
			if (result == true)
			{
				bmp.Save(dlg.FileName);
            }
            img.Source = null;
            model.SciezkaPliku = null;
        }

		/// <summary>
		/// Zdarzenie konwersji grafiki.
		/// </summary>
		private void ConvertButton_OnClick(object sender, RoutedEventArgs e)
        {
            if (bmp == null)
            {
                MessageBox.Show("Proszę najpierw załadować plik graficzny.", "ERROR", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            model.CzyAktywny = false;
            model.KonwertAktywny = false;
            Stopwatch stopWatch = new Stopwatch();
            List<Thread> threads = new List<Thread>();

            byte[] rgbValues = Konwerter.KonwertujBitmapeDoTablicy(bitmap: bmp);

            int pixels = (rgbValues.Length / 4);    // ilość pikseli
            if (model.Watki > pixels)
            {
                model.Watki = (short)(pixels);
                MessageBox.Show("Przekroczono bezpieczną liczbę wątków dla zbyt małego obrazka. Ustawiono optymalną liczbę wątków: " + model.Watki,
                    "Info", MessageBoxButton.OK, MessageBoxImage.Asterisk);
            }

            int rest = pixels % model.Watki;        // ostatnie piksele obrazka do przejęcia przez ostatni wątek
            int length = (pixels - rest) / model.Watki * 4;   // ilość elementów tablicy do przerobienia przez pojedynczy wątek


            int counter = 0;

            for (int j = 0; j < model.Watki - 1; j++)
            {
                int begin = counter;
                int end = counter + length;
                if (model.CsharpOK)
                {
                    threads.Add(new Thread(() => Konwerter_C.ConvertToSepia(rgbValues, begin, end, model.Sepia) ));
                }
                else
                {
                    threads.Add(new Thread(() => Konwerter_ASM.ConvertToSepia(rgbValues, begin, end, model.Sepia) ));
                }
                counter += length;
            }

            if (model.CsharpOK)
            {
                threads.Add(new Thread(() => Konwerter_C.ConvertToSepia(rgbValues, counter, rgbValues.Length, model.Sepia) ));
            }
            else
            {
                threads.Add(new Thread(() => Konwerter_ASM.ConvertToSepia(rgbValues, counter, rgbValues.Length, model.Sepia) ));
            }

            // mierzenie czasu wykonania pracy wątku/ów
            stopWatch.Start();
            threads.ForEach(thread => thread.Start());
            threads.ForEach(thread => thread.Join());
            stopWatch.Stop();
            
            StatusBarTextBlock.Text = String.Format("Przekonwertowano w {0} ms", stopWatch.Elapsed.Milliseconds);
            stopWatch.Reset();

            bmp = Konwerter.KonwertujTabliceNaBitmape(bitmap: bmp, rgbValues: rgbValues);

            //wyświetlenie przekonwertowanego obrazu w interfejsie
            img.Source = Konwerter.KonwertujBitmapeNaObraz(bmp);
            model.CzyAktywny = true;
        }
    }
}
