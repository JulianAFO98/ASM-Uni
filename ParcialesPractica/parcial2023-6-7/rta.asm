
nodo_size equ 8
nombre equ 0
nombre_arbol equ 8
siguiente equ 4
inicio_vec equ 124
cantHijos equ 14
primer_hijo equ 18
fecha equ 12
-----------------------------
push <puntero char>
call crear_nodo
add sp,4

crear_nodo: push bp
mov bp,sp
push nodo_size
call alloc
add sp,4
mov [eax+nombre],[bp+8]
mov sp,bp
pop bp
ret
-----------------------------
push <nodo* n>
push <nodo ** head>
call insert_nodo
add sp,8

insert_nodo: push bp
mov bp,sp

push edx
push ebx

mov edx,[bp+8];edx = **head
mov ebx,[bp+12];ebx = puntero nodo siguiente


mov [ebx+sig],[edx]
mov [edx],ebx

pop ebx
pop edx
mov sp,bp
pop bp
ret
-----------------------------

mov [0],'P'
mov [1],'e'
mov [2],'d'
mov [3],'r'
mov [4],'o'


main: push bp
mov bp,sp
sub sp,inicio_vec
push ecx
push edx

mov ecx,0

bucle: cmp 31,ecx
jn fin_bucle
mov edx,ecx
mul edx,4
add edx,bp
sub edx,inicio_vec
mov [edx],null
add ecx,1
jmp bucle

fin_bucle: push ds
call crear_nodo
add sp,4

mov edx,bp
sub edx,inicio_vec
add edx,8

push eax
push edx
call insert_nodo
add sp,8

pop edx
pop edx
add sp,inicio_vec
mov sp,bp
pop bp
ret

-----------------------------------
ej 2:

push <nodo*arbol>
push <mes>
push <puntero arreglo>
call cumplesxdia
add sp,12

cumplesxdia:push bp
mov bp,sp
push edx
push ecx
push ebx
push efx
push eax

mov edx,[bp+16]
cmp edx,null; si no es null el arbol
jz fin_cumplexdia

mov ecx,0
bucle: cmp [edx+cantHijos],ecx; mientras tenga hijos para recorrer
jz analizar_nodo
mov ebx,ecx
mul ebx,4
add ebx,primer_hijo
mov edx,[bp+16];hago que edx apunte denuevo al nodo ya que cambia en cada iteracion
add edx,ebx
; llamo recursivamente dentro del bucle
push [edx]
push [bp+12]
push [bp+8]
call cumplesxdia
add sp,16
add ecx,1; siguiente hijo
jmp bucle

analizar_nodo:  mov edx,[bp+16];reapuntamos nuevamente el nodo arbol para estar seguro
mov efx,[edx+fecha]
SHR efx,5
AND efx,0xFF; efx = mes
cmp efx,[bp+12];es el mes que busco?
jnz fin_cumplexdia; si no lo es me voy

push [edx+nombre_arbol];
call crear_nodo
add sp,4
;en eax tengo el nodo
;reutilizo ebx para buscar la pos en vector 

mov ebx,[bp+12];ebx = mes
mul ebx,4;
add ebx,[bp+8]; ebx + puntero a array 

push eax
push ebx
call insert_nodo
add sp,8


fin_cumplexdia: pop eax
pop efx
pop ebx
pop ecx
pop edx
mov sp,bp
ret




