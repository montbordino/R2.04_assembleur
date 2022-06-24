.DATA                   ; M A  P I L E      
    coordY  DW 0        ; | coordY  |    SP + 1
    hauteur DW 16       ; | hauteur |    SP + 2
    largeur DW 255      ; | largeur |    SP + 3
.CODE                   ; \_________/	
	LEA SP,STACK
	LD R6, 16			; R6 = compteur (sert à definir la fin de boucle)

	LD R5, 0
	OUT R5, 5

	LD R1, 0        ; R1 = coordX
    LD R2, 0	; R2 = couleur

    PUSH largeur		; constant
    PUSH hauteur		; constant
	PUSH coordY			; constant

boucle:	CMP R6, 0		; 256 = taille de la fenetre
		BEQ fin			; verification de la fin
		CALL rectDraw	; appel de la procédure
		
		;incr des paramètres
		DEC R6			; màj de condition d'arret

		ADD R1, 16	
		ADD R2, 16	
		JMP boucle
fin:	HLT	
	
rectDraw:   
			
			LD R0, [SP + 1] ; ajout de coordY
            OUT R0, 1		;
    
            OUT R1, 2		; ajout de coordX 
			LD R0, [SP + 3] ; ajout de largeur
			OUT R0, 3
            LD R0, [SP + 2] ; ajout de hauteur
            OUT R0, 4
		    LD R0, R2 ; ajout de couleur
            ADD R0, 5
            OUT R0, 5
            RET
.STACK 10