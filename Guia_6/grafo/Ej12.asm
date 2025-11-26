\\STACK 4000

n equ 4
inicio_vec equ 104

main: push bp
mov bp,sp
sub sp,inicio_vec
push edx 
push eax
push ecx
sys 0xf

mov [sp+12],0
mov [sp+16],1
mov [sp+20],1
mov [sp+24],0
mov [sp+28],1
sys 0xf

mov [sp+32],0
mov [sp+36],0
mov [sp+40],0
mov [sp+44],1
mov [sp+48],0
sys 0xf

mov [sp+52],0
mov [sp+56],1
mov [sp+60],0
mov [sp+64],1
mov [sp+68],0
sys 0xf

mov [sp+72],0
mov [sp+76],0
mov [sp+80],0
mov [sp+84],0
mov [sp+88],0
sys 0xf

mov [sp+92],0
mov [sp+96],1
mov [sp+100],0
mov [sp+104],0
mov [sp+108],0
mov [sp+112],5

sys 0xf
push 3;destino
push 0;origin 

push [bp-n]; n = 5 es cuadrada, no necesito m
sys 0xf
mov edx,bp
sub edx,inicio_vec
sys 0xf
push edx
push 5;cant vertices
sys 0xf
call cantidad_caminos
add sp,20
sys 0xf

mov edx,ds 
mov [edx],eax
mov eax,1
ldl ecx,1
ldh ecx,4
sys 2

pop ecx
pop eax
pop edx
add sp,inicio_vec
mov sp,bp
pop bp
ret



cantidad_caminos: push bp
mov bp,sp
sub sp,4
push ebx
push ecx
push edx
push eex
push efx

;[bp+16] = n
;[bp+8] = cantvertices 
mov eex,[bp+24];destino
mov efx,[bp+20];origen
mov ebx,[bp+12];ebx =puntero matriz

cmp eex,efx; origen == destino
jz iguales
mov [bp-4],0;int caminos = 0
mov ecx,0; i = 0

fori: cmp [bp+8],ecx;i < g->cant_vertices
jnp fin_for;
;contruimos [origen][i]
mov edx,efx; edx = origen
mul edx,[bp+16];edx = origen*n (m o n son iguales)
add edx,ecx; edx = (origen * n) + i
mul edx, 4; edx * tamcelda
add edx, ebx; quedo completo [origen][i]
cmp [edx],1
jnz siguiente_iteracion
push eex        ; destino (constante del contexto)
push ecx        ; nuevo origen (i)
push [bp+16]    ; n
push ebx        ; puntero matriz
push [bp+8]     ; cantVertices
call cantidad_caminos
add sp,20
;en eax esta el resultado de cantidad_caminos
add [bp-4],eax;caminos += contarCaminosRec(g, i, destino);
siguiente_iteracion: add ecx,1
jmp fori;

fin_for: mov eax,[bp-4]
jmp fin_cantidad_caminos

iguales: mov eax,1
fin_cantidad_caminos: pop efx
pop eex
pop edx
pop ecx
pop ebx
add sp,4
mov sp,bp
pop bp
ret