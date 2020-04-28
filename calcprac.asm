;;; Calculadora de dos digitos
;;; Por Santiago Betancur

.MODEL SMALL
.STACK
.DATA
    ; Consts
    MSG1 DB 10,13,'Oe...','$'
    MSG2 DB 10,13,'S: Sumar R: Restar M: Multiplicar D: Dividir ','$'
    MSG3 DB 10,13,'Ingrese un numero: ','$'
    MSG4 DB 10,13,'El resultado es: ','$'

    ; Input
    U DB 0
    D DB 0
    NUM1 DB 0
    NUM2 DB 0
    OPER DB ?
    RESULTADO DB ?
.CODE
    INICIO:
        MOV AX, seg @DATA
        MOV DS, AX
        
        MOV AH, 09H
        LEA DX, MSG1
        INT 21H

    MENU:
        ; Mostrar operaciones
        MOV AH, 09H
        LEA DX, MSG2
        INT 21H

        MOV AH, 01H
        INT 21H
        
        CMP AL, 'S'
            JE SUMA
        CMP AL, 'R'
            JE RESTA
        CMP AL, 'M'
            JE MULTIPLICAR
        CMP AL, 'D'
            JE DIVISION
        CMP AL, 'Q'
            JE SALIR
        JMP MENU

    SUMA:
        CALL INPUT_NUMEROS    

        MOV AL, NUM1
        ADD AL, NUM2
        MOV RESULTADO, AL

        JMP MOSTRAR_RESULTADO


    RESTA:
        CALL INPUT_NUMEROS

        MOV AL, NUM1
        SUB AL, NUM2
        MOV RESULTADO, AL
    
        JMP MOSTRAR_RESULTADO


    MULTIPLICAR:
        CALL INPUT_NUMEROS

        MOV AL, NUM1
        MOV BL, NUM2
        MUL BL
        MOV RESULTADO, AL

        JMP MOSTRAR_RESULTADO


    DIVISION:
        CALL INPUT_NUMEROS    

        XOR AX, AX
        MOV BL, NUM2
        MOV AL, NUM1
        DIV BL
        MOV RESULTADO, AL

        JMP MOSTRAR_RESULTADO


    SALIR:
        MOV	AX,4C00H
        INT 20H

    MOSTRAR_RESULTADO:
        MOV AH, 09H
        LEA DX, MSG4
        INT 21H

        MOV AL, RESULTADO
        AAM
        MOV BX, AX
        MOV AH, 02H
        MOV DL, BH
        ADD DL, 30H
        INT 21H

        MOV AH, 02H
        MOV DL, BL
        ADD DL, 30H
        INT 21H

        JMP MENU

    INPUT_NUMEROS:
        ; Ingresar primer numero
        MOV AH, 09H
        LEA DX, MSG3
        INT 21H

        MOV AH, 01H
        INT 21H
        SUB AL, 30H
        MOV D, AL

        MOV AH, 01H
        INT 21H
        SUB AL, 30H
        MOV U, AL
        
        MOV AL, D
        MOV BL, 10
        MUL BL
        ADD AL, U
        MOV NUM1, AL

        ; Ingresar segundo numero
        MOV AH, 09H
        LEA DX, MSG3
        INT 21H

        MOV AH, 01H
        INT 21H
        SUB AL, 30H
        MOV D, AL

        MOV AH, 01H
        INT 21H
        SUB AL, 30H
        MOV U, AL
        
        MOV AL, D
        MOV BL, 10
        MUL BL
        ADD AL, U
        MOV NUM2, AL
        
        RET
END
