;Realizar subrutinas para convertir:
;Un string, que representa un número entero (positivo o negativo) en base 10, a un número.




CONVERTIR_A_ENTERO:
    PUSH BP
    MOV BP,SP
    PUSH EDX
    SUB SP,4; BP+8 tendra mi n
    SUB SP,4; BP+12 tendra mi signo 
    SUB SP,4; BP +16 lo uso para el calculo del - '0'
    MOV EDX,[BP+8];EDX tiene el puntero a string
    MOV [BP+8], 0 ; n = 0
    MOV [BP+12],1 ; signo = 1
    CMP [EDX],'-';comparo con '-'
    JNZ BUCLE
    MOV [BP+12],-1 ; signo= -1
    ADD EDX,1;avanzo en 1 el puntero del string, supongo que no esta en la pila
BUCLE:
    CMP [EDX],0
    JZ FIN_BUCLE
    MOV [BP+16],[BP+8]; BP+16 = n
    MUL [BP+16],10 ; n*10
    ADD [BP+16],[EDX] ;(n * 10) + s[i]
    SUB [BP+16],'0'; o 48  (n * 10) + s[i] - '0'
    MOV [BP+8],[BP+16]; n=(n * 10) + s[i] - '0'
    ADD EDX,1
    JMP BUCLE
FIN BUCLE:
    MUL [BP+8],[BP+12];n = n * signo;
    MOV EAX,[BP+8];retorno en EAX
    ADD SP,12
    POP EDX
    MOV SP,BP
    POP BP
    RET


;Un número entero a su representación en string.

;se recibe un puntero a char y el entero a convertir(se supone espacio suficiente para el *char)
CONVERTIR_A_CADENA:
    PUSH BP
    MOV BP,SP
    PUSH EDX;guardo el puntero a char
    PUSH EBX;guardo el n
    PUSH ECX;variable contador de caracteres
    SUB SP,4;variable para contar
    MOV EDX,[BP+8];EDX ->puntero a char
    MOV EBX,[BP+12], EBX = n a convertir
    MOV ECX,0
CONTAR_CARACTERES_NUMERO:
    CMP [EDX],0
    JZ FIN_CONTAR_CARACTERES;si es el fin del string me voy
    ADD ECX,1;siguiente char
    ADD EDX,1;suma cont caracteres
    JMP CONTAR_CARACTERES_NUMERO
FIN_CONTAR_CARACTERES
    MOV EDX,[BP+8];reinicio el puntero porque lo perdi

    MOV SP,BP
    POP BP
    RET