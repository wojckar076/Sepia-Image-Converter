   M S B A M L   `   `   `  ����I  ESepiaConverter, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null/clr-namespace:SepiaConverterSepiaConverter  5   	       SepiaConverter.MainWindow   5   	   W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   .localclr-namespace:SepiaConverter     5   	     � Title$  Sepia��5   	   $	��445��6   $	��450��6$   .��5	      ]� .+�5
      �� $��Bottom=�6   .@�5      �� -   5         ��Name$ StatusBarTextBlock��5      $��Gotowy��6   6   5      � 5       � RowDefinitions 5      �� 5      $
��Auto �6   �� 5      �� 5      $
��Auto �6   �� 5      $
��Auto �6   $��48��6"   �� 5      $
��Auto �6   $��48��6"   �� 5      $
��Auto �6   .+�5      ��  �� Orientation$ Vertical=�6   $��0��6'   $��	10,10,0,0q�64   .+�5      �� $ 
Horizontal=�6   $��20��6*   .+�5      �� $��Ścieżka: ��6   �� 5      -   5         ��Name$ 
SourceFile��5      $	��300��6#   ��6/   ��  �� Path$ SciezkaPliku� �� Mode$ TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=��� 5      -   5         ��Name$ SourceButton��5      $��Przeglądaj��6$   $��10,0,0,0q�69   {�6h   �� $ 
CzyAktywny�5      �� 5      -   5        $ 
LoadButton��5      $��Otwórz��6   $��Center=�6u   $��0,5,0,0q�6�   {�6M   �� $ 
CzyAktywny�6�   5      �� 5      -   5        	 ��Name$		 img��5      $��1��6   $	��356��6%   $��Center=�61   �� 5      $ 
Horizontal=�6   $��2��6)   $��Center=�66   $	��120��6S   .+�5       	� 
 	� 	GroupName$
 	dllSource��6   $��60��6]    d� 	IsChecked 64   �� *AsmOK+$ TwoWay=�.��6h   ASM6m   	� 5!      $
 	dllSource��6   $��42��6`    64   �� *
CsharpOK+$ TwoWay=�.��6k   C#6o   5"      �� 5#      $ Vertical=�6   $��3��6'   $��	10,5,10,5q�64   .+�5$      �� $ 
Horizontal=�6   .+�5%      �� $��Ilość wątków:��6   �� 5&      -   5         ��Name$ ThreadsTextBlock��5&   9   $��10,0,0,0q�6'   ��6   �� *Watki+6U   5'      �� 5(      $	��100��6    � Minimum$ 1Q�6    � Maximum$ 64Q�6(    � Value 65   �� *Watki+$ TwoWay=�6\   5)      �� 5*      $ Vertical=�6   $��4��6'   $��	10,5,10,5q�64   .+�5+      �� $ 
Horizontal=�6   .+�5,      �� $��Sepia:��6   �� 5-      -   5        $ ThreadsSliderCopy��5-   9   $��10,0,0,0q�6'   ��6   �� *Sepia+6V   5.      �� 5/      -   5         ��Name$ SepiaSlider��5/       �� IsSnapToTickEnabled .  �� TickFrequency$ 1Q�6>   $ 20Q�6P   $ 40Q�6]    6j   �� *Sepia+$ TwoWay=�6�   50      �� 51      $��5��6   $ 
Horizontal=�6   $��Center=�66   $��	85,0,87,0q�6S   $	��270��6f   .+�52      �� -	   5        $ ConvertButton��52      $��	Konwertuj��6$   $	��100��68   $��10,5,0,5q�6D   {�6t   �� $ konwertAktywny��� 53      -
   5        $ 
SaveButton��53      $��Zapisz��6!   $	��100��62   $��50,5,0,5q�6>   {�6k   �� $ 
CzyAktywny�54      55      56      57      