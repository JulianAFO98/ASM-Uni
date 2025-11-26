\\include "list.asm"
\\include "binario.asm"
\\include  "heap.asm"
\\include "rta.asm"

lista_muestra equ "lista:\n"
arbol_muestra equ "arbol:\n"

head equ 4
head2 equ 8

main: push bp
    mov bp,sp
    sub sp,4;variable local head
    sub sp,4;varible local head arbol
    push edx

    call    heap_init 


    ;lista null
    mov [bp-head],null 
    ;creacion lista
    push 10
    call nodo_nuevo
    add sp,4

    mov edx,bp
    sub edx,head
    push eax
    push edx
    call insert_nodo
    add  sp, 8


    push 20
    call nodo_nuevo
    add sp,4

    mov edx,bp
    sub edx,head
    push eax
    push edx
    call insert_nodo
    add  sp, 8


    push 30
    call nodo_nuevo
    add sp,4

    

    mov edx,bp
    sub edx,head
    push eax
    push edx
    call insert_nodo
    add  sp, 8


    push 1
    call nodo_nuevo
    add sp,4

    

    mov edx,bp
    sub edx,head
    push eax
    push edx
    call insert_nodo
    add  sp, 8


    push 100
    call nodo_nuevo
    add sp,4
    mov edx,bp
    sub edx,head
    push eax
    push edx
    call insert_nodo
    add  sp, 8

    push 17
    call nodo_nuevo
    add sp,4
    mov edx,bp
    sub edx,head
    push eax
    push edx
    call insert_nodo
    add  sp, 8

    push 33
    call nodo_nuevo
    add sp,4
    mov edx,bp
    sub edx,head
    push eax
    push edx
    call insert_nodo
    add  sp, 8

    mov edx,ks
    add edx,lista_muestra
    sys 4

    push [bp-head]
    call list_print
    add sp,4


    ;arbol
    mov [bp-head2],null


    push 10
    call btn_new
    add sp,4

    mov edx,bp
    sub edx,head2
    push eax
    push edx
    call bst_add
    add sp,8

    push 30
    call btn_new
    add sp,4

    mov edx,bp
    sub edx,head2
    push eax
    push edx
    call bst_add
    add sp,8


    push 11
    call btn_new
    add sp,4

    mov edx,bp
    sub edx,head2
    push eax
    push edx
    call bst_add
    add sp,8


    mov edx,ks
    add edx,arbol_muestra
    sys 4

    push [bp-head2]
    call preorder
    add sp,4

    mov edx,bp
    sub edx,head
    push edx; push **lista
    push [bp-head2];push *nodo arbol
    call eliminar_b
    add sp,8

    mov edx,ks
    add edx,lista_muestra
    sys 4

    push [bp-head]
    call list_print
    add sp,4


main_end: pop edx
mov sp,bp
pop bp
ret




;----------------------------------------
; Remover nodo que aparezcan en el arbol
; parametro +8: puntero doble a lista
; parametro +12: puntero simple a nodo arbol 
;----------------------------------------
; invocación:
; push <nodoArbol *head>
; push <nodoLista** head>
; call eliminar_de_lista_estando_en_arbol
; add  sp, 8
;----------------------------------------


eliminar_de_lista_estando_en_arbol: push bp
mov bp,sp
push edx
push ebx
push ecx
push eax

mov edx,[bp+8];edx = doble puntero lista
mov ebx,[edx];ebx = puntero simple lista
mov ecx,[bp+12];ecx = puntero nodo_arbol*

cmp ebx,null
jz fin_eliminar_de_lista
push [ebx+val]
push ecx
call existe_en_arbol
add sp,8
cmp eax,0
jz no_eliminar_nodo
add ebx,sig
mov [edx],[ebx]
jmp invocacion_eliminar
no_eliminar_nodo: add ebx,sig
invocacion_eliminar: push ecx
push ebx
call eliminar_de_lista_estando_en_arbol
add sp,8
fin_eliminar_de_lista: pop eax
pop ecx
pop ebx
pop edx
mov sp,bp
pop bp
ret