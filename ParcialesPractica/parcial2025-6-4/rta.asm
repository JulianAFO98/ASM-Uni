node_size equ 10
id equ 0
nombre equ 2
sig equ 6
cantHijos equ 12
hijos equ 14
atributos equ 2
--------------------

****LLAMADA****
push <char*>
push <id>
call lnode_new
add sp,8
****LLAMADA****

lnode_new: push bp
mov bp,sp

push node_size
call malloc
add sp,4

cmp eax,null
jz fin_lnode_new
mov [eax+id],[bp+8]
mov [eax+nombre],[bp+12]
mov [eax+sig],null

fin_lnode_new: mov sp,bp
pop bp
ret

-----------------------------
****LLAMADA****
push <lnode*>
push <lnode**>
call list_insert_sorted
add sp,8
****LLAMADA****

list_insert_sorted: push bp
mov bp,sp
push edx
push eax
push ebx

mov edx,[bp+8];edx = doble puntero lista
mov ebx,[edx]; ebx = puntero simple lista
mov eax,[bp+12]; eax = puntero simple nodo

cmp eax,null
jz fin_list_insert_sorted

bucle: cmp ebx,null
jz insertar
cmp [ebx+id],[eax+id]
jnn insertar
add ebx,sig
mov edx,ebx
mov ebx,[edx]
jmp bucle

insertar: mov [eax+sig],[edx]
mov [edx],eax

fin_list_insert_sorted: pop ebx
pop eax
pop edx
mov sp,bp
pop bp
ret

----------------------------------
ej 2:
----------------------------------
****LLAMADA****
push <anode*>
call files_read_only
add sp,4
****LLAMADA****


files_read_only: push bp
mov bp,sp
sub sp,4
push edx
push eax
mov [bp-4],null
mov edx,bp
sub edx,4

push edx
push [bp+8]
call _files_read_only
add sp,8

pop eax
pop edx
add sp,4
mov sp,bp
pop bp
ret


****LLAMADA****
push <lnode**>
push <anode*>
call _files_read_only
add sp,8
****LLAMADA****

_files_read_only: push bp
mov bp,sp
push edx
push ebx
push ecx
push eex

mov edx,[bp+8];puntero arbol

mov ecx,0
mov ebx,[edx+hijos];puede ser null

bucle cmp [edx+cantHijos],ecx 
jz analizar_nodo

push [bp+12]
push [ebx]
call _files_read_only
add sp,8

add ebx,4
add ecx,1
jmp bucle

analizar_nodo: mov eex,w[edx+atributos]
shr eex,9
and eex,0x1
cmp eex,0
jnz no_insertar
mov eex,w[edx+atributos]
and eex,0b100
cmp eex,4
jnz no_insertar

;es nodo correcto,inserto
push [edx+nombre]
push [edx+id]
call lnode_new
add sp,8

push eax
push [bp+12]
call list_insert_sorted
add sp,8

no_insertar: pop eex
pop ecx
pop ebx
pop edx
mov sp,bp
pop bp
ret






