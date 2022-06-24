.DATA 
    coordY  DW 0       
    hauteur DW 16
    largeur DW 20

	couleur DW 240
	SPress	DW %11000111
	BPress	DW %11000110
	APress 	DW %11000101
.CODE	

	LEA SP,STACK		; SP dans la pile
	
	LD R0, 0
	OUT R0, 5			; efface tout l'écran

	PUSH largeur		; constant
    PUSH hauteur		; constant
	PUSH coordY			; constant

	CALL affichagePalette
	; ___________________________________________________
	;/												     \
	;| A T T E N T E   D ' U N   C L I C K   S O U R I S |
	;\___________________________________________________/
souris: IN R0, 0
		CMP R0, APress
		BNE testB
		LD R6, 0
testB:	CMP R0, BPress
		BNE testS
		CALL effaceEcr
testS:	CMP R0, SPress
		BNE souris

		IN R1, 6			; R1 = x Souris ---------------------------------
		IN R2, 7			; R2 = Y Souris ---------------------------------

	; _____________________________________________
	;/								               \
	;| P R E M I E R   E L S E / I F  C O U L E U R |
	;\_____________________________________________/	
		CMP R1, largeur
		BGTU choix2			; si x > 20 on saute le changement de Coul

		LD R3, R2			; R3 = couleur stylo ------------------------------------
		DIVU R3, 16
		MULU R3, 16
		ADD R3, 2

		JMP souris			; retour au debut de la boucle

	; _____________________________
	;/				               \
	;| S E C O N D   E L S E / I F |
	;\_____________________________/	
choix2: 
		CMP R6, 0
		BNE sinon
		LD R6, 1
		JMP changCoord

sinon:	CALL traceLigne

changCoord:	LD R4, R1		; R4 = ancienne coordX ----------------------------------
			LD R5, R2		; R5 = ancienne coordY -----------------------------------

			JMP souris		; retour au debut de la boucle ---------------------------




affichagePalette:
		LD R6, 16			; R6 = compteur (sert à definir la fin de boucle)
		LD R1, 0       		; R1 = coordX
		LD R2, 0			; R2 = couleur

	boucleCouleurs:	
			CMP R6, 0
			BEQ finPalette	; verification de la fin
			CALL rectDraw	; appel de la procédure
			
			;incr des paramètres
			DEC R6			; màj de condition d'arret

			ADD R1, 16	
			ADD R2, 16	
			JMP boucleCouleurs
	finPalette:
			LD R6, 0		; R6 = premierclick ---------------------------------
			RET
traceLigne:
			OUT R4, 1
			OUT R5, 2
			OUT R1, 3
			OUT R2, 4
			OUT R3, 5
			RET

effaceEcr:
			LD R0, largeur
			OUT R0, 1
			LD R0, 0
			OUT R0, 2
			LD R0, 255
			OUT R0, 4
			SUB R0, largeur
			OUT R0, 3
			LD R0, 5
			OUT R0, 5
			CALL affichagePalette
			RET
rectDraw:   	
			LD R0, [SP + 2] ; ajout de coordY
            OUT R0, 1		;
            OUT R1, 2		; ajout de coordX 
			LD R0, [SP + 4] ; ajout de largeur
			OUT R0, 3
            LD R0, [SP + 3] ; ajout de hauteur
            OUT R0, 4
		    LD R0, R2 ; ajout de couleur
            ADD R0, 5
            OUT R0, 5
            RET
.STACK 10

