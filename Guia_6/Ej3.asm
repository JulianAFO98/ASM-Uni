heapinit:
MOV [ES],ES
ADD [ES],4
RET

main:
PUSH BP
MOV BP,SP
SUB SP,4;int *z
SUB SP,4; int vec[]
; z = malloc(sizeof(int))
PUSH 4;tamaño de un byte
CALL MALLOC
ADD SP,4
MOV [BP-4],EAX;int *z = puntero a int en heap,EAX tiene el puntero
 ; vec = malloc(sizeof(int) * 100)
MOV EAX,4;sizeof(int)
MUL EAX,100;int *100
PUSH EAX
CALL MALLOC
ADD SP,4
MOV [BP-8],EAX;int vec[] = malloc(sizeof(int) * 100);
; *z = 100
MOV EAX,[BP-4];EAX = puntero a heap
MOV [EAX],100
 ; funcion1(vec, *z)
PUSH [EAX]; mandamos el valor de *z (100)
PUSH [BP-8]; mandamos direccion del vec
CALL FUNCION1
ADD SP,4
ADD SP,4
ADD SP,4
ADD SP,4
MOV SP,BP
POP BP
RET



FUNCION1:
PUSH BP
MOVE BP,SP
PUSH EDX
PUSH EBX
SUB SP,4;int s
SUB SP,4;int i
MOVE EDX,[BP+8];EDX = puntero vector o sea pos 0
MOV [EDX],1; v[0] = 1
MOV [BP-16],1;i=1
BUCLE_FUNCION1:
CMP [BP-16],[BP+12];i<z
JNN FIN_BUCLE_FUNCION1;salto si no es negativo
;calculo la pos en base a i, ya que cada celda del vector tiene 4 bytes
MOV EBX,[BP-16];EBX = i 
MUL EBX,4; EBX * 4 (tamaño celda)
ADD EBX,EDX; le sumo el puntero para obtener la direccion correcta
MOV [EBX],[EBX-4];vec[i] = vec[i-1]
MUL [EBX],[BP-16];vec[i] = vec[i-1] * i;
ADD [BP-16],1;i++
JMP BUCLE_FUNCION1
FIN_BUCLE_FUNCION1:
MOV EBX,BP;reutilizo ebx para llegar a &z(bp+12)
ADD EBX,12
PUSH EBX;push &z
PUSH EDX;mi puntero a vector
CALL SUM 
ADD SP,4
ADD SP,4
MOV [BP-12],EAX; s = sum(vec, &z);
PUSH [BP-12];
PRINT_INT
ADD SP,4
ADD SP,4;libero i
ADD SP,4;libero s
POP EBX
POP EDX
MOV SP,BP
POP BP
RET


SUM:
PUSH BP
MOV BP,SP
PUSH EBX
PUSH ECX
MOV l[0],0;sin l da igual, por defecto es 4
MOV EAX,0;i=0
MOV EBX,[BP+8];ebx = puntero a n
BUCLE_SUM:
CMP EAX,[EBX];i<*n
JNN FIN_BUCLE_SUMA
;calculo pos de i
MOV ECX,EAX;ECX = i
MUL ECX,4;MUL ECX * tamaño celda 
ADD ECX,[BP+12];sumo a ecx el puntero del vector
ADD l[0],[ECX]
ADD EAX,1
JMP BUCLE_SUM
MOV EAX,l[0]
POP ECX
POP EBX
MOV SP,BP
POP BP
RET