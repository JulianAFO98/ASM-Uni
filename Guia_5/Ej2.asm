;SLEN: recibe un puntero a un string y devuelve en ECX la cantidad de caracteres (sin incluir
;el terminator) del string.


PUSH EDX;EDX tiene mi puntero
CALL SLEN
ADD SP,4

SLEN:
;Prologo
PUSH BP
PUSH EAX
MOVE BP,SP
;Cuerpo
MOV ECX,0;contador de caracteres en 0
MOV EAX,[BP+8];traigo puntero que esta en [EDX+0]
bucle:
CMP [EAX],0
JZ fin
ADD EAX,1; EDX+1 siguiente byte
ADD ECX,1
JMP bucle
fin:
;Epilogo
MOVE SP,BP
POP EAX
POP BP
RET

;SCPY: recibe dos punteros y permite copiar una cadena de caracteres de una posición de
:memoria a otra.

PUSH EDX;EDX tiene mi puntero con el string
PUSH EAX; mi puntero destino
CALL SCPY
ADD SP,4
ADD SP,4

SCPY:
;Prologo
PUSH BP
MOVE BP,SP
PUSH EBX
PUSH ECX
;Cuerpo
MOV EBX,[BP+12];traigo puntero que esta en [EDX+0]
MOV ECX,[BP+8]
bucle:
MOV [ECX],[EBX]
CMP [EBX],0
JZ fin
ADD EBX,1; EDX+1 siguiente byte
ADD ECX,1
JMP bucle
fin:
;Epilogo
POP ECX
POP EBX
MOVE SP,BP
POP BP
RET

;SCMP: recibe dos punteros a strings, y resta carácter a carácter (sin alterar los strings)
;hasta que exista una diferencia devolviendola en EAX o 0 si los strings son iguales.

PUSH EDX;EDX tiene mi puntero con el string
PUSH ECX; mi puntero con el otro string
CALL SCMP
ADD SP,4
ADD SP,4

SCMP:
;Prologo
PUSH BP
MOVE BP,SP
PUSH EFX
PUSH EBX
;Cuerpo
MOV EBX,[BP+12];traigo puntero que esta en [EDX+0]
MOV EFX,[BP+8];traigo puntero que esta en [EFX+0]
bucle:
CMP [EBX],[EFX]
JNZ fin
ADD EBX,1; EDX+1 siguiente byte
ADD EFX,1; EFX+1
JMP bucle
fin:
;Epilogo 
MOV EAX,[EBX]
SUB EAX,[EFX]
POP EBX
POP EFX
MOVE SP,BP
POP BP
RET


;SCAT: recibe dos punteros a strings y concatena al primero el segundo (es responsabilidad
;del programador que a continuación del primer string no se pisen datos).

;PUSH EDX puntero de s1
;PUSH EBX puntero de s2
;call SCAT
;ADD sp,4
;ADD sp,4
SCAT:
    PUSH BP
    MOVE BP, SP
    PUSH EDX
    PUSH EBX

    MOV EDX, [BP+12] ; primer string (destino)
BUSCAR_FIN_CADENA:
    MOV AL, [EDX]
    CMP AL, 0
    JZ ENCONTRO_FIN_CADENA
    ADD EDX, 1
    JMP BUSCAR_FIN_CADENA
ENCONTRO_FIN_CADENA:
    MOV EBX, [BP+8]     ; segundo string (origen)
COPIAR_CADENA:
    MOV AL, [EBX]
    CMP AL, 0
    JZ PONER_TERMINATOR
    MOV [EDX], AL
    ADD EBX, 1
    ADD EDX, 1
    JMP COPIAR_CADENA
PONER_TERMINATOR:
    MOV b[EDX], 0   ; agrego null terminator
FIN_SCAT:
    MOV EAX, [BP+12]  ; puntero al string destino
    POP EBX
    POP EDX
    MOVE SP, BP
    POP BP
    RET


;SPLIT: recibe un puntero a string, un carácter, y un puntero a un array de punteros. Divide el
;strings en varios strings reemplazando el carácter por el terminator y completa el array de
;punteros con el puntero al primer carácter de cada string, utilizando -1 para marcar el fin.


PUSH EDX;puntero a string
PUSH ECX;char
PUSH EBX;puntero a array de punteros
CALL SPLIT
ADD SP,4
ADD SP,4
ADD SP,4



SPLIT:
    PUSH BP
    MOVE BP,SP
    PUSH EDX
    PUSH EBX
    MOV EDX,[BP+18];EDX = puntero al string
    MOV EBX,0;contador para el vector de punteros
    MOV EAX,[BP+8];por defecto el EAX tendra el puntero al array de punteros
    MOV [EAX],EDX;por defecto el string completo es apuntado por el vector de punteros v[0] = 'stringcompleto\0"
BUCLE_SPLIT:
    CMP [EDX],0;es el caracter actual == 0? o sea el final
    JZ FIN_SPLIT;si da 0 nos vamos del bucle
    CMP [EDX],[BP+12];es caracter actual igual al caracter del parametro?
    JZ CORTAR_CADENA
    ADD EDX,1;si no es asi sigo buscando el caracter(el string no esta en la pila,por eso suma en lugar de restar)
    JMP BUCLE_SPLIT
CORTAR_CADENA:
    MOV [EDX],0;pongo el terminator en el caracter actual
    ADD EBX,1;el 0 ya esta ocupado por el string completo,sumo 1 para la siguiente pos
    MOV EAX,EBX;uso EAX para calcular la posicion en el vector de punteros
    MUL EAX,4; i * 4
    ADD EAX,[BP+8];EAX + el puntero al vector de strings
    ADD EDX,1; el inicio de la siguiente palabra esta EDX + 1
    MOV [EAX],EDX
    JMP BUCLE_SPLIT

FIN_SPLIT:
    MOV EAX,[BP+8]
    MUL EBX,4
    ADD EAX, EBX
    MOV [EAX], -1;coloco -1 al final
    MOV EAX, [BP+8];en eax retorno el vector de punteros
    POP EBX
    POP EDX
    MOVE SP,BP
    POP BP
    RET

;STRIM: recibe un puntero a string como parámetro variable, y devuelve el string quitando los
;“espacios” (white spaces) del comienzo y del final


PUSH EDX;edx tiene el puntero a string
CALL STRIM;devuelve en eax
ADD SP,4



STRIM:
    PUSH BP
    MOV BP,SP
    PUSH EDX;sostiene el puntero a string
    MOV EDX,[BP+8];[EDX] = 'H' por ejemplo siendo 'H' el primer char
BUCLE_STRIM_INICIAL:
    CMP [EDX],0;mientras no me caiga del string
    JZ PONER_CERO_FINAL
    CMP [EDX],' ';comparo con vacio
    JNZ CAMBIAR_PUNTERO_STRIM;si no es vacio,entonces es otro caracter u otra cosa distinto de espacio
    ADD EDX,1;siguiente char en el string
    JMP BUCLE_STRIM_INICIAL
CAMBIAR_PUNTERO_STRIM:
    MOV EAX,EDX;pongo el puntero EAX,apuntando al primer char distinto de ' '

RECORRER_STRING_HASTA_FINAL:
    CMP [EDX],0;mientras no me caiga del string
    JZ FINAL_RECORRER_STRING
    ADD EDX,1
    JMP RECORRER_STRING_HASTA_FINAL

;aqui edx ya queda apuntando al '\0' y EAX en el primer char sin espacio
;ahora recorro desde el 0 para atras en busca del primer valor diferente de espacio
FINAL_RECORRER_STRING:
    SUB EDX,1
    CMP [EDX],' ';verifico que haya un vacio al menos
    JZ PONER_CERO_FINAL;si no hay espacios ya termine
BUCLE_STRIM_SEGUNDO:
    CMP [EDX],' ';mientras sean espacios
    JNZ PONER_CERO_FINAL
    SUB EDX,1;avanzo hacia atras     <---- direccion izquierda en el vector
    JMP BUCLE_STRIM_SEGUNDO
PONER_CERO_FINAL:
    ADD EDX,1;sumo 1 para no pisar un valor valido
    MOV [EDX],0
    POP EDX
    MOV SP,BP
    POP BP
    RET


