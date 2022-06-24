.DATA                   ; M A  P I L E
    hauteur DW 16       ; | hauteur | <- SP + 1
    largeur DW 256      ; | largeur |    SP + 2
    coordY  DW 0        ; | coordY  |    SP + 3
    coordX  DW 0        ; | coordX  |    SP + 4
    couleur DW 32       ; | couleur |    SP + 5
.CODE                   ; \_________/
    LEA SP, STACK
    PUSH couleur
    PUSH coordX
    PUSH coordY
    PUSH largeur
    PUSH hauteur

    CALL rectDraw
    HLT    

rectDraw:   LD R0, [SP + 4] ; ajout de coordX 
            OUT R0, 1
            LD R1, [SP + 3] ; ajout de coordY
            OUT R1, 2
            LD R2, [SP + 2] ; ajout de largeur
            OUT R3, 4
            LD R4, [SP + 1]     ; ajout de hauteur
            OUT R4, 3
            LD R5, [SP + 5] ; ajout de couleur
            ADD R5, 5
            OUT R5, 5
            RET
.STACK 6