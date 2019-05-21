; Sepia
; Wojciech Karbownik
; INF 4, sem 5, gr 8

; Funkcja dodaj¹ca czêœci (lub od razu ca³oœci, przy pracy na jednym w¹tku) 32-bitowej bitmapy efekt sepii.
; Argumenty przekazywane do funkcji:
; RCX - adres pierwszego elementu tablicy
; RDX - indeks pierwszego elementu tablicy do konwersji
; R8 - indeks ostatniego elementu tablicy do konwersji
; R9 - wspó³czynnik sepii

.data
.CODE

Konwerter PROC
	PUSH RSI							; zapis rejestru Ÿród³a do stosu
	MOV RSI, RCX						; za³adowanie adresu pierwszego bajtu z tablicy do rejestru RSI
	ADD RSI, RDX						; zachowanie indeksu pierwszego elementu w rejestrze RSI
	SUB R8, RDX							; ró¿nica bajtów do konwersji - odjêcie pierwszego indeksu tablicy od ostatniego
	MOV R10, 3							; zapis cyfry 3 typu int w rejestrze R10
	CVTSI2SD xmm3, R10					; rzutowanie typu int na double - za³adowanie zawartoœci rejestru R10 (liczba 3) do xmm3

Petla:									; g³ówna pêtla operuj¹ca na pojedynczych pikselach
	MOVZX R10, byte ptr[RSI]			; przypisanie bajtu z kolorem niebieskim do rejestru R10
	CVTSI2SD xmm0, R10					; rzutowanie int na double i zachowanie wyniku w rejestrze xmm0
	MOVZX R10, byte ptr[RSI+1]			; przypisanie bajtu z kolorem zielonym do rejestru R10
	CVTSI2SD xmm1, R10					; rzutowanie int na double i zachowanie wyniku w rejestrze xmm1
	MOVZX R10, byte ptr[RSI+2]			; przypisanie bajtu z kolorem zielonym do rejestru R10
	CVTSI2SD xmm2, R10					; rzutowanie int na double i zachowanie wyniku w rejestrze xmm2
	ADDSD xmm0, xmm1					; sumowanie wartoœci RGB piksela w rejestrach SSE
	ADDSD xmm0, xmm2
	DIVPD xmm0, xmm3					; podzielenie sumy przez 3 - uzyskanie skali szaroœci piksela
	CVTSD2SI R10, xmm0					; rzutowanie double na int œredniej wartoœci RGB piksela i zachowanie wyniku w rejestrze R10
	MOV RAX, R10						; przypisanie œredniej wartoœci RGB piksela (skali szaroœci) do rejestru RAX
	MOV byte ptr[RSI], AL				; przypisanie nowej wartoœci koloru niebieskiego z najm³odszego offsetu rejestru RAX

	ADD RAX, R9							; dodanie wartoœci sepii do wczeœniej wyliczonej œredniej wartoœci RGB piksela
	CMP RAX, 255						; sprawdzenie, czy suma nowej wartoœci nie przekracza 255 - ustawienie flagi
	JL Green255							; instrukcja skoku do etykiety w przypadku, gdy suma nie przekracza 255
	MOV RAX, 255						;	w przeciwnym wypadku zmiana wartoœci green na 255
 Green255:
	MOV byte ptr[RSI + 1], AL			; przypisanie nowej wartoœci koloru zielonego z najm³odszego offsetu rejestru RAX
	
	MOV RAX, R10						; przypisanie œredniej wartoœci RGB piksela (skali szaroœci) do rejestru RAX
	ADD RAX, R9							; dwukrotne dodanie wartoœci sepii do œr. wartoœci RGB
	ADD RAX, R9
	CMP RAX, 255						; sprawdzenie, czy suma nowej wartoœci nie przekracza 255 - ustawienie flagi
	JL Red255							; instrukcja skoku do etykiety w przypadku, gdy suma nie przekracza 255
	MOV RAX, 255						;	w przeciwnym wypadku zmiana wartoœci red na 255
 Red255:
	MOV byte ptr[RSI + 2], AL			; przypisanie nowej wartoœci koloru czerwonego z najm³odszego offsetu rejestru RAX
	ADD RSI, 4							; inkrementacja tablicy bajtów o 4 indeksy (1 piksel)
	SUB R8, 4							; sprawdzenie, czy po odjêciu 4, indeks ostatniego elementu tablicy jest ró¿ny od 0 (czy to nie by³ ostatni piksel)
	JNZ Petla							; jeœli jest ró¿ny od 0 - skok do nastêpnego obiegu pêtli
	POP RSI								; zwrócenie zawartoœci ze stosu do rejestru Ÿród³a RSI
	RET
Konwerter ENDP
END