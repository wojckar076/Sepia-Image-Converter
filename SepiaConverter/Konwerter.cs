using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Runtime.InteropServices;
using System.Windows.Media.Imaging;

namespace SepiaConverter
{
	public static class Konwerter
	{
		/// <summary>
		/// Zmiana formatu pikseli na 32ARGB.
		/// </summary>
		public static Bitmap ZmianaFormatuPikseli(Bitmap img)
		{
			var bmp = new Bitmap(img.Width, img.Height, PixelFormat.Format32bppArgb);
			using (var gr = Graphics.FromImage(bmp))
				gr.DrawImage(img, new Rectangle(0, 0, img.Width, img.Height));
			return bmp;
		}

		/// <summary>
		/// Konwersja bitmapy na obraz, który można wyświetlić w interfejsie użytkownika.
		/// </summary>
		public static BitmapImage KonwertujBitmapeNaObraz(Bitmap bitmap)
		{
			using (MemoryStream memory = new MemoryStream())
			{
				bitmap.Save(memory, ImageFormat.Png);
				memory.Position = 0;
				BitmapImage bitmapImage = new BitmapImage();
				bitmapImage.BeginInit();
				bitmapImage.StreamSource = memory;
				bitmapImage.CacheOption = BitmapCacheOption.OnLoad;
				bitmapImage.EndInit();
				return bitmapImage;
			}
		}

		/// <summary>
		/// Konwersja bitmapy do tablicy bajtów.
		/// </summary>
		public static byte[] KonwertujBitmapeDoTablicy(Bitmap bitmap)
		{
			BitmapData bmpData = bitmap.LockBits(new Rectangle(0, 0, bitmap.Width, bitmap.Height)
				, ImageLockMode.ReadWrite, bitmap.PixelFormat);

			int bytes = Math.Abs(bmpData.Stride) * bitmap.Height;
			byte[] rgbValues = new byte[bytes];

			Marshal.Copy(bmpData.Scan0, rgbValues, 0, bytes);

			return rgbValues;
		}

		/// <summary>
		/// Konwersja tablicy bajtów na bitmapę.
		/// </summary>
		public static Bitmap KonwertujTabliceNaBitmape(Bitmap bitmap, IReadOnlyList<byte> rgbValues)
		{
			int height = bitmap.Height;
			int width = bitmap.Width;

			Bitmap bmp = new Bitmap(width, height, PixelFormat.Format32bppArgb);

			Color c;
			int k = 0;
			for (int i = 0; i < height; i++)
			{
				for (int j = 0; j < width; j++)
				{
					c = Color.FromArgb(rgbValues[k + 3], rgbValues[k + 2], rgbValues[k + 1], rgbValues[k]);
					bmp.SetPixel(j, i, c);
					k += 4;
				}
			}
			return bmp;
		}
	}
}
