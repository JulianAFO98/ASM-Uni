
valRTA equ 0
izq equ 4
der equ 8

;push <valRTA>
;push <nodoA*>
;call buscar_b
;add sp,8

buscar_b: push bp
mov bp,sp

push edx

mov edx,[bp+8]; edx = nodo arbol

cmp edx,null
jz no_encontrado

cmp [edx+valRTA],[bp+12]
jz encontrado
jp por_izquierda

;por derecha
push [bp+12]
push [edx+der]
call buscar_b
add sp,8
jmp fin_buscar_b

por_izquierda: push [bp+12]
push [edx+izq]
call buscar_b
add sp,8
jmp fin_buscar_b

encontrado: mov eax,1
jmp fin_buscar_b
no_encontrado: mov eax,0

fin_buscar_b: pop edx
mov sp,bp
pop bp
ret

;push <nodol **>
;push <nodoarbol*>
;call eliminar_b
;add sp,8

eliminar_b: push bp
mov bp,sp

push edx
push ebx

mov edx,[bp+12];puntero lista doble
mov ebx,[edx]; puntero simple lista

cmp ebx,null
jz fin_eliminar_b

push [ebx+valRTA]
push [bp+8]
call buscar_b
add sp,8

cmp eax,1
jnz siguiente_nodo
;elimino nodo
mov [edx],[ebx+sig]
mov [ebx+sig],null
push ebx
call free
add sp,4
jmp invocacion_eliminando

siguiente_nodo: add ebx,sig
push ebx
push [bp+8]
call eliminar_b
add sp,8
jmp fin_eliminar_b

invocacion_eliminando: push edx
push [bp+8]
call eliminar_b
add sp,8

fin_eliminar_b: pop ebx
pop edx
mov sp,bp
pop bp
ret




