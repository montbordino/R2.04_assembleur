.DATA
	grandCoord			DW 78
	grandLargeur		DW 100
	petitCoord			DW 103
	petitLargeur		DW 50
	carre				DW %01110101

	BPress			DW %11000110	; R3 = B pressé
	ALach			DW %10000101	; R5 = A laché
	APress			DW %11000101	; R4 = A pressé
.CODE
		LEA SP, STACK
		LD R6, 0
		OUT R6, 5			; efface l'ecran

		LD R1, grandCoord		; registres <- variables 
		LD R2, grandLargeur		;
		LD R3, petitCoord		;
		LD R4, petitLargeur		;
		LD R5, carre
		CALL grand			; trace le premier carré

main: 	IN R0, 0			; recupere le click de la souris
		CMP R0, BPress
		BEQ fin				; Bpress -> fin
		CMP R0, APress		
		BNE suite			; Apress -> grand
		CALL petit

suite:	CMP R0, ALach		
		BNE main			; Alach -> petit
		CALL grand
		JMP main			; retour au début

grand:	LD R0, R1		; ajout grandCoord
		OUT R0, 1
		OUT R0, 2
		LD R0, R2		; ajout grandLargeur
		OUT R0, 3
		OUT R0, 4
		LD R0, R5		; ajout couleur + forme
		OUT R0, 5	
		RET      		; retourne dans le main

petit:	OUT R6,5			; vide l'écran
		LD R0, R3		; ajout grandCoord
		OUT R0, 1
		OUT R0, 2
		LD R0, R4		; ajout grandLargeur
		OUT R0, 3
		OUT R0, 4
		LD R0, R5		; ajout couleur
		OUT R0, 5
		RET				; retourne dans le main

fin:	HLT

.STACK 1