.DATA
valinit DW 6
Fact    DSW 1
.CODE
	LD R0,1
	LD R1,2
boucle: CMP R1,valinit
	BGTU suite
	MULU R0,R1
	INC R1
	JMP boucle
suite:  ST R0,Fact
	HLT
