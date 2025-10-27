\\STACK 1024
\\include  "lista_doble_circular.asm"

lista_orig  equ     "lista original:\n"
lista_fin equ  "lista final:\n"
head        equ     4
main:       push    bp
            mov     bp, sp
            sub     sp, 4 ; head  (variable local)
            push    ebx

            sys     0xF

            call    heap_init ;inicializa heap
            ;declaro lista
            mov     [bp-head], null     ; nodo* head = null
            mov     ebx, bp
            sub     ebx, head           ; ebx = &head

            sys     0xF
            
            push    10
            call    nodo_nuevo
            add     sp, 4
            push eax         
            push ebx
            call insert_nodo
            add sp,8

            sys     0xF            

            push    20
            call    nodo_nuevo
            add     sp, 4
            push eax         
            push ebx
            call insert_nodo
            add sp,8            

            sys     0xF
            
            push    30
            call    nodo_nuevo
            add     sp, 4
            push eax          
            push ebx
            call insert_nodo
            add sp,8

            sys     0xF
            push    30
            call    nodo_nuevo
            add     sp, 4
            push eax          
            push ebx
            call insert_nodo
            add sp,8

            sys     0xF
            push    15
            call    nodo_nuevo
            add     sp, 4
            push eax          
            push ebx
            call insert_nodo
            add sp,8

            sys     0xF
            push    15
            call    nodo_nuevo
            add     sp, 4
            push eax          
            push ebx
            call insert_nodo
            add sp,8

            sys     0xF
            push    30
            call    nodo_nuevo
            add     sp, 4
            push eax          
            push ebx
            call insert_nodo
            add sp,8

            sys     0xF
            push    30
            call    nodo_nuevo
            add     sp, 4
            push eax          
            push ebx
            call insert_nodo
            add sp,8

            sys     0xF

            push    20
            call    nodo_nuevo
            add     sp, 4
            push eax          
            push ebx
            call insert_nodo
            add sp,8

            sys     0xF

            push    10
            call    nodo_nuevo
            add     sp, 4
            push eax          
            push ebx
            call insert_nodo
            add sp,8

            sys     0xF

            push    15
            call    nodo_nuevo
            add     sp, 4
            push eax          
            push ebx
            call insert_nodo
            add sp,8

            sys     0xF

            push    10
            call    nodo_nuevo
            add     sp, 4
            push eax          
            push ebx
            call insert_nodo
            add sp,8

            sys     0xF
            
            ; mensaje lista original
            mov     edx, ks
            add     edx, lista_orig
            sys     0x4

            ; imprimir la lista
            push    [bp-head]
            call    mostrar_lista_doble          ; list_print (head)
            add     sp, 4      

            push [bp-head]
            call eliminar_duplicados
            add sp,4
            

            ; mensaje lista original
            mov     edx, ks
            add     edx, lista_fin
            sys     0x4

            ; imprimir la lista
            push    [bp-head]
            call    mostrar_lista_doble          ; list_print (head)
            add     sp, 4     

            sys     0xF
            pop ebx
            add sp,4
            mov sp,bp
            pop bp
            ret