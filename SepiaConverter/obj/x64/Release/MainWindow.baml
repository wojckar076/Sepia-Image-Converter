   M S B A M L   `   `   `  ���� I  ESepiaConverter, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null/clr-namespace:SepiaConverterSepiaConverter      SepiaConverter.MainWindow   W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     .localclr-namespace:SepiaConverter       � Title$  Sepia��$	��445��$	��450��.��]� .+��� $��Bottom=�.@��� -    ��Name$ StatusBarTextBlock��$��Gotowy���  � RowDefinitions �� $
��Auto ��� �� $
��Auto ��� $
��Auto �$��48���� $
��Auto �$��48���� $
��Auto �.+���  �� Orientation$ Vertical=�$��0��$��	10,10,0,0q�.+��� $ 
Horizontal=�$��20��.+��� $��Ścieżka: ���� -    ��Name$ 
SourceFile��$	��300������  �� Path$ SciezkaPliku� �� Mode$ TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=��� -    ��Name$ SourceButton��$��Przeglądaj��$��10,0,0,0q�{��� $ 
CzyAktywny��� -   $ 
LoadButton��$��Otwórz��$��Center=�$��0,5,0,0q�{��� $ 
CzyAktywny��� -   	 ��Name$		 img��$��1��$	��356��$��Center=��� $ 
Horizontal=�$��2��$��Center=�$	��120��.+�	� 
 	� 	GroupName$
 	dllSource��$��60�� d� 	IsChecked �� *AsmOK+$ TwoWay=�.��ASM	� $
 	dllSource��$��42�� �� *
CsharpOK+$ TwoWay=�.��C#�� $ Vertical=�$��3��$��	10,5,10,5q�.+��� $ 
Horizontal=�.+��� $��Ilość wątków:���� -    ��Name$ ThreadsTextBlock��$��10,0,0,0q����� *Watki+�� $	��100�� � Minimum$ 1Q� � Maximum$ 64Q� � Value �� *Watki+$ TwoWay=��� $ Vertical=�$��4��$��	10,5,10,5q�.+��� $ 
Horizontal=�.+��� $��Sepia:���� -   $ ThreadsSliderCopy��$��10,0,0,0q����� *Sepia+�� -    ��Name$ SepiaSlider�� �� IsSnapToTickEnabled .  �� TickFrequency$ 1Q�$ 20Q�$ 40Q� �� *Sepia+$ TwoWay=��� $��5��$ 
Horizontal=�$��Center=�$��	85,0,87,0q�$	��270��.+��� -	   $ ConvertButton��$��	Konwertuj��$	��100��$��10,5,0,5q�{��� $ konwertAktywny��� -
   $ 
SaveButton��$��Zapisz��$	��100��$��50,5,0,5q�{��� $ 
CzyAktywny�