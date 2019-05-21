using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace SepiaConverter
{
	/// <summary>
	/// Abstrakcyjna klasa do modyfikacji elementów modelu widoku.
	/// </summary>
	public abstract class ModelWidokuRodzic : INotifyPropertyChanged
	{
		public event PropertyChangedEventHandler PropertyChanged;

		protected bool SetProperty<T>(ref T storage, T value, [CallerMemberName] string propertyName = null)
		{
			if (value == null ? storage != null : !value.Equals(storage))
			{
				storage = value;
				PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
				return true;
			}
			return false;
		}
	}
}
