
val 0
parbol equ 4
sig equ 4
hijos equ 4
;----------------------------------------
; Elimina el valor de los  arboles de cada nodo de la lista,
; si queda vacio el nodo lo elimina 
; parametro +8: puntero doble a la lista
; parametro +12: valor a eliminar
;----------------------------------------
; invocación:
; push <valor>
; push <nodo** head>
; call  recorrer_lista_eliminando
; add   sp, 8
;----------------------------------------

recorrer_lista_eliminando: push bp
mov bp,sp
push edx
push ebx

mov edx,[bp+8];edx = puntero doble
mov ebx,[edx]; ebx = puntero simple

cmp ebx,null;mientras no me caiga
jz fin_recorrer_eliminando
push [bp+12];valor a eliminar
push ebx;push puntero doble a nodo arbol nario
call eliminar_de_nario
add sp,8
cmp [ebx+parbol],null
jnz nodo_siguiente;mi nodo arbol no esta en null,avanzo al sig nodo
add ebx,sig;ebx ahora es doble puntero
mov [edx],[ebx]
nodo_siguiente: push ebx
push [bp+12]
call recorrer_lista_eliminando
add sp,8
fin_recorrer_eliminando: pop ebx
pop edx
mov sp,bp
pop bp
ret


;----------------------------------------
; Elimina el valor de los  arboles
; parametro +8: puntero doble a la arbol
; parametro +12: valor a eliminar
;----------------------------------------
; invocación:
; push <valor>
; push <nodoarbol** head>
; call  recorrer_lista_eliminando
; add   sp, 8
;----------------------------------------

eliminar_de_nario: push bp
mov bp,sp
push edx
push ebx
push ecx
push eax
push eex
mov edx,[bp+8];puntero doble a nodo arbol
mov ebx,[edx];puntero simple a nodo arbol

cmp ebx,null; si esta vacio me voy
jz fin_eliminar_nario

;voy hasta el fondo del arbol
add ebx,hijos
cmp [ebx],null; si tiene hijos
jz fin_eliminar_nario

mov ecx,[ebx];ahora  ecx es puntero a la estructura con nodo arbol* y siguiente*

;llamo recursividad hacia la derecha y hacia abajo
;hacia abajo
push [bp+12]
push ecx;ahora doble puntero
call eliminar_de_nario
add sp,8
;hacia la derecha
push [bp+12]
add ecx,sig
push ecx
call eliminar_de_nario
add sp,8

; a la vuelta de la recursividad veo si tengo que eliminar a mi hijo
; desde la vista del nodo, todos son raiz, y solo conocen su hijo mas proximo
; deberia conectar, si es el valor que deseo, el hijo de su hijo, y si no tiene su hermano

mov ebx,[edx];vuelvo a hacer que ebx apunte al nodo arbol,para claridad
add ebx,hijos; apunta a hijos nuevamente,para claridad
mov ecx,[ebx];ecx ahora tiene el primer hijo, para claridad,ya se que no es null, pero es doble puntero
mov ecx,[ecx];bajo otro nivel
cmp [ecx+val],[bp+12]; es mi primer hijo el buscado?
jz fin_eliminar_nario

;mi hijo tiene hijos?
cmp [ecx+hijos],null
jz sin_hijos
;debo hacer 3 asignaciones
;su hijo ascenderlo, sus hermanos sean sus hijos,su siguiente es el hermano del anterior nodo
con_hijos: mov eax,[ebx];recupero al hermano para no perderlo en la reasignacion
add eax,sig
mov eax,[eax];puede ser null el hermano
mov eex,[ecx+hijos];voy a buscar a su primer hijo
mov ebx,[edx]
mov ebx,[ebx+hijos]
mov [ebx],[eex];de doble puntero a doble puntero,ahora conecte abuelo a sobrino
mov [eex],[eex+sig];mis hermanos ahora son mis hijos
mov [eex+sig],eax;pongo los hermanos del nodo viejo como hermanos de este nodo

jmp fin_eliminar_nario
sin_hijos: mov eax,[ebx];recupero al hermano
add eax,sig
mov eax,[eax];puede ser null el hermano
mov ebx,[edx]
mov ebx,[ebx+hijos];
mov [ebx],eax;enlazo hermano puede ser null

fin_eliminar_nario: pop ebx
pop edx
mov sp,bp
pop bp
ret


