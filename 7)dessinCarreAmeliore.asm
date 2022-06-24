.DATA
	grandLargeur	DW 100
	petitLargeur	DW 50
	carre			DW %01110101

	BPress			DW %11000110	; pressé
	ALach			DW %10000101	; laché
	APress			DW %11000101	; pressé
	SPress			DW %11000111	; Souris

.CODE
		LEA SP, STACK

		LD R0, 0			; efface l'ecran
		OUT R0, 5			;

souris: IN R0, 0
		CMP R0, SPress
		BNE souris
			
		IN R1, 6			; R1 = x Souris
		IN R2, 7			; R2 = Y Souris

		CMP R1, 50		; Test si les coordonnées sont dans le cadre
		BLTU souris		;
		CMP R2, 50		;
		BLTU souris		;

		SUB R1, 50		;	Décalage des coordonnées
		SUB R2, 50		;

		LD R3, grandLargeur
		LD R4, petitLargeur	
		LD R5, carre

		CALL grand

main: 	IN R0, 0			; recupere le click de la souris
		CMP R0, BPress
		BEQ fin				; Bpress -> fin
		CMP R0, APress		
		BNE suite			; Apress -> grand
		CALL petit

suite:	CMP R0, ALach		
		BNE main		; Alach -> petit
		CALL grand
		JMP main		; retour au début

grand:	LD R0, R1		; ajout grandCoord
		OUT R0, 1
		LD R0, R2
		OUT R0, 2
		LD R0, R3		; ajout grandLargeur
		OUT R0, 3
		OUT R0, 4
		LD R0, R5		; ajout couleur + forme
		OUT R0, 5	
		RET      		; retourne dans le main

petit:	OUT R6,5			; vide l'écran

		ADD R1, 25		; change les coords
		ADD R2, 25

		LD R0, R1		; ajout petitCoord
		OUT R0, 1
		LD R0, R2
		OUT R0, 2
		LD R0, R4		; ajout petitLargeur
		OUT R0, 3
		OUT R0, 4
		LD R0, R5		; ajout couleur
		OUT R0, 5

		SUB R1, 25		; remet les coords
		SUB R2, 25		;
		RET				; retourne dans le main

fin:	HLT

.STACK 1