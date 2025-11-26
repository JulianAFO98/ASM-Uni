nodo_size equ 12
null equ -1
val equ 0
nivel equ 4
sig equ 8
hijos equ 4
-------------------------
push <nivel>
push <val>
call crear_nodo
add sp,8
-------------------------
crear_nodo: push bp
mov bp,sp
push nodo_size
call alloc
add sp,4
cmp eax,null
jz fin_crear_nodo
mov [eax+val],[bp+8]
mov [eax+nivel],[bp+12]
mov [eax+sig],null

fin_crear_nodo: mov sp,bp
pop bp
ret

----------------------
push <nodol* nodo>
push <nodol** head>
call insert_sort
add sp,8
----------------------
insert_sort: push bp
mov bp,sp

push edx
push ebx
push eax

mov edx,[bp+8]
mov ebx,[edx]
mov eax,[bp+12]

bucle: cmp ebx,null
jz insertar
cmp [ebx+nivel],[eax+nivel]
jnn insertar
add ebx,sig
mov edx,edx
mov ebx,[edx]
jmp bucle

insertar: mov [eax+sig],[edx]
mov [edx],eax

pop eax
pop ebx
pop edx
mov sp,bp
pop bp
ret


-------------------------
push <nodoA * root>
call crear_lista_pornivel
add sp,4
-------------------------
crear_lista_pornivel: push bp
mov bp, sp
sub sp,4

push edx

mov [bp-4],null
mov edx,bp
sub edx,4

push edx
push [bp+8]
push 0
call _crear_lista_pornivel
add sp,12

mov eax,[bp-4]
pop edx
add sp,4
mov sp,bp
pop bp
ret
--------------------
push <nodol** head>
push <nodoA* root>
push nivel
call _crear_lista_pornivel
add sp,8
--------------------
_crear_lista_pornivel: push bp
mov bp,sp

push edx
push ebx
push ecx

mov ebx,[bp+12];ebx = nodo* arbol
mov ecx,0
mov edx,[bp+8];edx = nivel
add edx,1

cmp ebx,null
jz fin_crear_lista
mov ecx,[ebx+hijos]
bucle_crear: cmp [ecx],null
jz insertar_crear
push [bp+16]
push [ecx]
push edx
call _crear_lista_pornivel
add sp,16
add ecx,4
jmp bucle_crear

insertar_crear: push [bp+8]
push [ebx+val]
crear_nodo
add sp,8

push eax
push [bp+16]
call insert_sort
add sp,8



fin_crear_lista: pop ecx
pop ebx
pop edx
mov sp,bp
pop bp
ret


