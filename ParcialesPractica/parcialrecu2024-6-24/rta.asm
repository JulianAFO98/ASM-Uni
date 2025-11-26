valor equ 0
sig equ 4

-----------------------
push <node**head>
call clone
add sp,4
-----------------------

clone: push bp
mov bp,sp

push ebx
push edx

mov edx,[bp+8];
cmp [edx],null
jz retornar_null
mov ebx,[edx]
push [ebx+valor]
call new_node
add sp,4
;reutilizo ebx
mov ebx,eax ;n = new_node()

mov edx,[edx]
add edx,sig
push edx
call clone 
add sp,4
mov [ebx+sig],eax
jmp retornar_lista
retornar_null: mov eax,null
jmp fin_clone
retornar_lista: mov eax,ebx
fin_clone: pop edx
pop ebx
mov sp,bp
pop bp
ret

---------------------
push <node* buscado>
push <node* header>
call exists
add sp,8
---------------------

exists: push bp
mov bp,sp

push edx
push ebx


mov edx,[bp+12];edx = header lista
mov ebx,[bp+8];ebx = buscado

bucle: cmp edx,null
jz no_existe
cmp edx,ebx
jz existe
mov edx,[edx+sig]
jmp bucle

no_existe: mov eax,0
jmp fin_existe
existe: mov eax,1
fin_existe: pop ebx
pop edx
mov sp,bp
pop bp
ret
----------------------
push <node** headerA>
push <node** headerB>
call split
add sp,8
----------------------

split: push bp
mov bp,sp

push edx
push ebx
push ecx 

mov edx,[bp+8];edx = puntero doble a B
mov ebx,[bp+12];ebx = puntero doble a A
mov ecx,[edx]; ecx = puntero simple a B 

bucle_split: cmp ecx,null
jz no_existe_interseccion
push ecx
push [ebx]
call exists
add sp,8
cmp eax,1
jz clonar
mov ecx,[ecx+sig]
jmp bucle_split







