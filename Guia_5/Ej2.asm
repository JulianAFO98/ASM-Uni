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