.DATA
 chaine  DW "bonjour ceci est une chaine de caracteres longue qui permet de tester ce programme."
 taille  DW 10
 codeFin DW '.'
.CODE
		LD R0, 0	   ; effacer l'écran
		OUT R0, 5
		LEA R1, chaine ; R1 = @ de chaine
		LD R2, codeFin ; R2 = code de fin
		LD R0, 1       ; definir epaisseur du trait
		OUT R0, 4
		LD R0, 20 	   ; initialisation des coordonées de départ
		OUT R0, 1 
		LD R0, 20
		OUT R0, 2
boucle:	CMP [R1], R2   ; Test de fin de chaine
		BEQ fin

		IN  R3, 1      ; R3 = ancien coord x
		IN  R5, 2      ; R5 = ancien coord y

		LD R0, [R1]    ; ecriture du caractère pointé par R1
		OUT R0, 3
		LD R0, %11110111	
		OUT R0, 5	   ; affichage du caractère

		IN R4, 1       ; R4 = nouvelle coord x

		CMP R4, R3     ; test si il y a eu retour à la ligne		
		BGT normal
		
		IN R6, 2       ; R6 = nouvelles coord y
		
		ADD R5, 2
		OUT R5, 2
		SUB R5, 2

		LD R0, 245;
		OUT R0, 1;
		OUT R3, 10;
		LD  R0, %11110101
		OUT R0, 5	   ; affichage du rectangle

		OUT R4, 1
		OUT R6, 2
		
		INC R1
		JMP boucle

normal:	OUT R3, 1      ; retour a l'ancienne coord x

			   ; changement de coord y
		ADD R5, 2
		OUT R5, 2
		SUB R5, 2

		LD  R6, R4
		SUB R6, R3    ;calcul de la longueur		
		OUT R6, 3     ; ecriture du rectangle
		LD  R0, %11110101
		OUT R0, 5	   ; affichage du rectangle

		OUT R5, 2
		OUT R4, 1

		INC R1         ; changement à la lettre suivante
		JMP boucle     ; retour au début de la boucle
fin:   	HLT