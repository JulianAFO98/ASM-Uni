\\include  "heap.asm"
;  Lista doblemente enlazada

; Estructura del nodo:
;    +------------+
;  0 |   entero   |  (4 bytes)
;    +------------+
; +4 | *anterior |  (4 bytes)
;    +------------+
; +4 | *siguente |  (4 bytes)
;    +------------+
nodo_size   equ     12
val         equ     0
ant         equ     4
sig         equ     8

;----------------------------------------
; crea un nuevo nodo de la lista 
; parámetros: +8 valor entero
;----------------------------------------
; invocación:
; push  <valor entero>
; call  nodo_nuevo
; add   sp, 4
; << eax puntero al nuevo nodo
;----------------------------------------
nodo_nuevo:     push    bp
                mov     bp, sp

                push    nodo_size
                call    alloc
                add     sp, 4      

                cmp     eax, null
                jz      nodo_nuevo_fin

                mov     [eax+val], [bp+8]
                mov     [eax+sig], null
                mov     [eax+ant], null
nodo_nuevo_fin: mov     sp, bp
                pop     bp
                ret 

;----------------------------------------
; Inserta un nodo en la lista circular doble 
; parametro +8: doble puntero a la lista
; parametro +12: puntero al nodo a insertar
;----------------------------------------
; invocación:
; push <nodo* nuevo_nodo>
; push <nodo** head>
; call  insertar_nodo
; add   sp, 8
;----------------------------------------

insert_nodo: push bp
mov bp,sp
push edx
push ebx
push eax

mov edx,[bp+8];doble puntero
mov ebx,[edx];puntero simple
mov eax,[bp+12];puntero a nodo a insertar

cmp ebx,null;lista vacia?
jz insertar_vacia
; ---lista no vacia ---
mov [eax+sig],ebx
mov ebx,[ebx+ant]
mov [eax+ant], ebx

mov [ebx+sig],eax
mov ebx,[edx]
mov [ebx+ant],eax

mov [edx], eax;actualizo cabecera
jmp insertar_fin
;-- lista vacia --
insertar_vacia: mov [eax+sig],eax; nodo -> sig = nodo
mov [eax+ant],eax; nodo -> ant = nodo
mov [edx],eax; 

jmp insertar_fin
insertar_fin: pop eax
pop ebx
pop edx
mov sp,bp
pop bp
ret



;----------------------------------------
; Mostrar lista doblemente enlazada
; parametro +8: puntero simple a la lista
;----------------------------------------
; invocación:
; push <nodo* head>
; call  insertar_nodo
; add   sp, 4
;----------------------------------------

mostrar_lista_doble: push bp
mov bp,sp
push edx
push ebx
push ecx
push eax

mov eax,1
ldl ecx,1
ldh ecx,4

mov ebx,[bp+8];puntero simple(direccion de corte)
cmp ebx,null
jz fin_muestra

mov edx,ebx

bucle_muestra: sys 2
mov edx,[edx+sig]
cmp ebx,edx
jnz bucle_muestra

fin_muestra: pop eax
pop ecx
pop ebx
pop edx
mov sp,bp
pop bp
ret


;----------------------------------------
; Eliminar repetidos de lista doblemente enlazada circular 
; parametro +8: puntero simple a la lista
;----------------------------------------
; invocación:
; push <nodo* head>
; call  eliminar_duplicados
; add   sp, 4
;----------------------------------------
eliminar_duplicados: push bp
mov bp,sp
push edx
push ebx
push ecx
push eax;para aux

mov edx,[bp+8];puntero que usare para terminar el tercer bucle
cmp edx,null
jz fin_eliminar_duplicados

mov ebx,edx;puntero que usare en el segundo bucle,para comparar
mov ecx,[ebx+sig];puntero que se movera buscando repetidos

tercer_bucle: cmp ebx,ecx
jz siguiente_vuelta
cmp [ecx+val],[ebx+val]
jz eliminar_nodo
mov ecx,[ecx+sig]
jmp tercer_bucle
eliminar_nodo: mov eax,[ecx+ant]
mov [eax+sig],[ecx+sig];
mov eax,[ecx+sig];
mov [eax+ant],[ecx+ant];
mov ecx,[ecx+sig];
jmp tercer_bucle

siguiente_vuelta: mov ebx,[ebx+sig]
cmp ebx,edx;si ya recorri todos los posibles me voy
jz fin_eliminar_duplicados
mov ecx,[ebx+sig]
jmp tercer_bucle

fin_eliminar_duplicados: pop eax
pop ecx
pop ebx
pop edx
mov sp,bp
pop bp
ret





