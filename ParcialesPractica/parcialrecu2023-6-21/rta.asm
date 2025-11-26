ing equ 0
id_ing equ 0
izq equ 4
der equ 8
lista equ 9
limite equ 9
cantidad equ 4
sellos equ 8
mask equ 4
sig equ 6

busca_abb: push bp
mov bp,sp

push ebx
push edx

mov eax,null
mov ebx,[bp+8]

cmp ebx,null; root != null
jz fin_busca_abb
mov edx,[ebx+ing]
cmp [edx+id_ing],[bp+12]; primera condicion
jnz elseif
mov eax,[ebx+ing]
jmp fin_busca_abb
elseif: cmp [edx+id_ing],[bp+12]; 
jnp else
push [bp+12]
push [ebx+izq]
call busca_abb
add sp,8
;en eax ya queda el valor buscado, no lo asigno nuevamente
jmp fin_busca_abb
else: push [bp+12]
push [ebx+der]
call busca_abb
add sp,8
;no asigno eax ya que nuevamente retorna en eax
fin_busca_abb: pop edx
pop ebx
mov sp,bp
pop bp
ret

-----------------------------------------------------
push <producto>
push <ab root>
call completasellos
add sp,8
-----------------------------------------------------
completasellos: push bp
mov bp,sp
push edx
push ebx
push eax

mov edx,[bp+12];edx = puntero producto
mov ebx,[edx+lista]

bucle:  cmp ebx,null; mientras no llege al final de  la lista
        jz fin_completasellos
        push [ebx+id_ing]
        push [bp+8];root* 
        call busca_abb
        add sp,8
        cmp eax,null;si no es null el producto
        jz siguiente_iteracion
        cmp [eax+limite],w[ebx+cantidad]; si no sobrepasa el limite
        jnn siguiente_iteracion
        or b[edx+sellos],b[eax+mask]
        siguiente_iteracion: mov ebx,[ebx+sig]
        jmp bucle

fin_completasellos: pop eax
pop ebx
pop edx
mov sp,bp
pop bp
ret
