
-----------------------------------
Ej 1:
-----------------------------------

inicial equ 0
nombre equ 1
sig equ 5

--------------------------------------------

nnom_add: push bp
mov bp,sp
push edx
push ebx
;eax no lo guardo ya que se guarda en un procedimiento anterior


mov eax,[bp+12];eax = *nuevo
cmp eax,null
jz fin_nnom_add

mov edx,[bp+8];register nnom** n = header
mov ebx,[edx];puntero simple 

bucle_otro: cmp ebx,null
jz asignacion
cmp [ebx+inicial],[nuevo+inicial]
jz asignacion
add ebx,sig
mov edx,ebx; n = &(*n)->sig
mov ebx,[edx];para continuar el bucle
jmp bucle_otro

asignacion: mov [nuevo+sig],[edx];nuevo->sig = *n
mov [edx],nuevo;*n = nuevo

fin_nnom_add: pop ebx
pop edx
mov sp,bp
pop bp
ret

----------------------------------------------

nnom_create: push bp
mov bp,sp
push ebx
push ecx

push 9
call alloc
add sp,4

mov ebx,eax; register nnom* r = alloc(9)

cmp ebx,null; if (r != null)
jz fin_nnom_create
mov ecx,[bp+8];recupero  puntero nombre
mov [ebx+inicial],[ecx]; r->inicial = *nombre
mov [ebx+nombre],ecx; r->nombre = nombre
mov [ebx+sig],null; r->sig = null

fin_nnom_create: mov eax,ebx
pop ecx
pop ebx
mov sp,bp
pop bp
ret


-----------------------------------------------



alloc: push bp
mov bp,sp
push ebx

mov eax,null

mov ebx,w[es+2]
add ebx,[bp+8]
cmp ebx,es_size
jp alloc_end
mov eax,[es]
add [es],[bp+8]


alloc_end: pop ebx
mov sp,bp
pop bp
ret


-----------------------------------
Ej 2:
-----------------------------------

get_mayores: push bp
mov bp,sp
sub sp,4
;podria hacerse con menos registros
push eax
push ebx
push ecx
push edx
push eex
push efx

mov [bp-4],null;*head = null
mov edx,[bp+8]; edx = puntero lista 
mov ecx,[bp+12]; ecx = fecha

cmp edx,null; mientras no sea null la lista
jz fin_get_mayores

mov ebx,[edx+persona]; ebx = puntero a tipo persona
mov efx,[ebx+nacimiento]; efx = fecha persona
cmp ecx,efx; fecha ecx < efx?
jp  siguiente;si da positivo no cumple condicion de a partir, son fechas mas viejas
; 2003 - 2002 -> positivo -> fecha no valida

shr efx,16; fecha >> 16
and efx,0x0000FFFF;puede ser 0xFFFF
mov eex,2025
sub eex,efx;2025 - 2003 por ejemplo
cmp eex,18
jn siguiente; no es mayor de 18
; si es mayor de de 18 hago esto
add ebx,nombre; nombre son bytes puros, tengo que pasarle un puntero a la func
push ebx
call nnom_create
add sp,4
;no me preocupo por los null ya que las func los manejan
;en eax esta mi nodo creado
push eax
;reuso edx 
mov edx,bp
sub edx,4
push edx;mando doble puntero  -> &head
call nnom_add
add sp,8
;aqui ya se acomodo el nodo donde debe
;me preparo para la siguiente llamada

siguiente: push ecx; envio fecha
;reuso edx nuevamente
mov edx,[bp+8];
push [edx+sig];mando siguiente nodo
call get_mayores
add sp,8
fin_get_mayores: pop efx
pop eex
pop edx
pop ecx
pop ebx
pop eax
add sp,4
mov sp,bp
pop bp
ret









