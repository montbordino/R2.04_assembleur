.DATA
 chaine DW "bonjour"
		DW 0
 maxi   DW '0'
.CODE
			LEA R2,chaine
			LD R1, '0'
boucle:  	LD R0, [R2]		; R0 <- caractère pointé par R2

			CMP R0, 0      	; R2 == 0
			BEQ suite		;
			CMP R1,R0		; sinon
			BGT inchange
			LD R1, R0
inchange:   INC R2 
			JMP boucle	
suite:      ST R1,maxi		   ; Maxi <- R1
	   		HLT