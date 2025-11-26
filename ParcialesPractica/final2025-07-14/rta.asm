null equ -1
value equ 0
der equ 6
izq equ 2

find_pos: push bp
mov bp,sp

push ebx


mov eax,[bp+8]; eax = btn** root

bucle: mov ebx,[eax]
cmp ebx,null
jz fin_find_pos
cmp w[ebx+value],w[bp+14]
jz fin_find_pos
jn else
add ebx,der
mov eax,ebx
jmp bucle
else: add ebx,izq
mov eax,ebx
jmp bucle

fin_find_pos: pop ebx
mov sp,bp
pop bp
ret
........................
push <btn **root>
call bt_to_search
add sp,4
........................

bt_to_search: push bp
mov bp,sp
add sp,4
push edx
push ebx

mov ebx,[bp+8]
mov [bp-4],null
mov edx,bp
sub edx,4
push edx
push ebx
call _bt_to_search
add sp,8

mov [ebx],[edx]

pop edx
sub sp,4
mov sp,bp
pop bp
ret

........................
push <btn **destino>
push <btn **origin>
call bt_to_search
add sp,8
........................
_bt_to_search: push bp
mov bp,sp

push edx
push ebx
push ecx
push eex

mov edx,[bp+8];destino
mov ebx,[edx];puntero simple destino

cmp ebx,null
jz fin_bt_to_search

mov ecx,ebx
add ecx,izq
push ecx
push [bp+12]
call _bt_to_search
add sp,8


mov ecx,ebx
add ecx,der
push ecx
push [bp+12]
call _bt_to_search
add sp,8


push w[ebx+value]
push ebx
call existe_ab
add sp,8

cmp eax,1
jz eliminar_nodo

push edx
push w[ebx+value]
call find_pos
add sp,8
mov [eax],ebx
jmp sigue

eliminar_nodo: push ebx
call free
add sp,4


sigue: mov [edx],null
pop ebx
pop edx
mov sp,bp
pop bp
ret


existe_ab: push bp
mov bp,sp

push edx
push ebx
push cx

mov edx,[bp+8]; doble puntero abb
mov ebx,[edx];puntero simple abb
mov cx,w[bp+14]

cmp ebx,null
jz no_existe
cmp w[ebx+value],cx
jz existe_ab
jn por_derecha
push cx
add ebx,izq
push ebx
call existe_ab
add sp,8
jmp fin_existe
por_izquierda: push cx
add ebx,der
push ebx
call existe_ab
add sp,8
jmp fin_existe

no_existe: mov eax,0
jmp fin_existe
existe_ab: mov eax,1
jmp fin_existe

fin_existe: pop cx
pop ebx
pop edx
mov sp,bp
pop bp
ret



