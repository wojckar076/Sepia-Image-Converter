; Sepia
; Wojciech Karbownik
; INF 4, sem 5, gr 8

; Funkcja dodaj�ca cz�ci (lub od razu ca�o�ci, przy pracy na jednym w�tku) 32-bitowej bitmapy efekt sepii.
; Argumenty przekazywane do funkcji:
; RCX - adres pierwszego elementu tablicy
; RDX - indeks pierwszego elementu tablicy do konwersji
; R8 - indeks ostatniego elementu tablicy do konwersji
; R9 - wsp�czynnik sepii

.data
.CODE

Konwerter PROC
	PUSH RSI							; zapis rejestru �r�d�a do stosu
	MOV RSI, RCX						; za�adowanie adresu pierwszego bajtu z tablicy do rejestru RSI
	ADD RSI, RDX						; zachowanie indeksu pierwszego elementu w rejestrze RSI
	SUB R8, RDX							; r�nica bajt�w do konwersji - odj�cie pierwszego indeksu tablicy od ostatniego
	MOV R10, 3							; zapis cyfry 3 typu int w rejestrze R10
	CVTSI2SD xmm3, R10					; rzutowanie typu int na double - za�adowanie zawarto�ci rejestru R10 (liczba 3) do xmm3

Petla:									; g��wna p�tla operuj�ca na pojedynczych pikselach
	MOVZX R10, byte ptr[RSI]			; przypisanie bajtu z kolorem niebieskim do rejestru R10
	CVTSI2SD xmm0, R10					; rzutowanie int na double i zachowanie wyniku w rejestrze xmm0
	MOVZX R10, byte ptr[RSI+1]			; przypisanie bajtu z kolorem zielonym do rejestru R10
	CVTSI2SD xmm1, R10					; rzutowanie int na double i zachowanie wyniku w rejestrze xmm1
	MOVZX R10, byte ptr[RSI+2]			; przypisanie bajtu z kolorem zielonym do rejestru R10
	CVTSI2SD xmm2, R10					; rzutowanie int na double i zachowanie wyniku w rejestrze xmm2
	ADDSD xmm0, xmm1					; sumowanie warto�ci RGB piksela w rejestrach SSE
	ADDSD xmm0, xmm2
	DIVPD xmm0, xmm3					; podzielenie sumy przez 3 - uzyskanie skali szaro�ci piksela
	CVTSD2SI R10, xmm0					; rzutowanie double na int �redniej warto�ci RGB piksela i zachowanie wyniku w rejestrze R10
	MOV RAX, R10						; przypisanie �redniej warto�ci RGB piksela (skali szaro�ci) do rejestru RAX
	MOV byte ptr[RSI], AL				; przypisanie nowej warto�ci koloru niebieskiego z najm�odszego offsetu rejestru RAX

	ADD RAX, R9							; dodanie warto�ci sepii do wcze�niej wyliczonej �redniej warto�ci RGB piksela
	CMP RAX, 255						; sprawdzenie, czy suma nowej warto�ci nie przekracza 255 - ustawienie flagi
	JL Green255							; instrukcja skoku do etykiety w przypadku, gdy suma nie przekracza 255
	MOV RAX, 255						;	w przeciwnym wypadku zmiana warto�ci green na 255
 Green255:
	MOV byte ptr[RSI + 1], AL			; przypisanie nowej warto�ci koloru zielonego z najm�odszego offsetu rejestru RAX
	
	MOV RAX, R10						; przypisanie �redniej warto�ci RGB piksela (skali szaro�ci) do rejestru RAX
	ADD RAX, R9							; dwukrotne dodanie warto�ci sepii do �r. warto�ci RGB
	ADD RAX, R9
	CMP RAX, 255						; sprawdzenie, czy suma nowej warto�ci nie przekracza 255 - ustawienie flagi
	JL Red255							; instrukcja skoku do etykiety w przypadku, gdy suma nie przekracza 255
	MOV RAX, 255						;	w przeciwnym wypadku zmiana warto�ci red na 255
 Red255:
	MOV byte ptr[RSI + 2], AL			; przypisanie nowej warto�ci koloru czerwonego z najm�odszego offsetu rejestru RAX
	ADD RSI, 4							; inkrementacja tablicy bajt�w o 4 indeksy (1 piksel)
	SUB R8, 4							; sprawdzenie, czy po odj�ciu 4, indeks ostatniego elementu tablicy jest r�ny od 0 (czy to nie by� ostatni piksel)
	JNZ Petla							; je�li jest r�ny od 0 - skok do nast�pnego obiegu p�tli
	POP RSI								; zwr�cenie zawarto�ci ze stosu do rejestru �r�d�a RSI
	RET
Konwerter ENDP
END