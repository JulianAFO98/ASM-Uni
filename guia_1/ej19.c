

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

int toNumber(char *num);
int potencia(int base, int exponente);
int suma(int a,int b);
int and(int a,int b);
int copy(int a,int b);
int not(int a,int b);

int main(int argc, char *argv[])
{
    int op,n1,n2;
    if (argc < 3) {
        printf("error falta parametro A");
        return -1;
    }
    op = toNumber(argv[1]);
    if(op >= 4) {
        printf("error operacion invalida");
        return -1;
    }
    
    n1 = toNumber(argv[2]);
    n2 = argc>= 4 ?  toNumber(argv[3]) : 0;
    printf("%d %d %d\n",op,n1,n2);

    int (*operaciones[])(int,int) = {suma,and,copy,not};
   
    printf("%d\n",operaciones[op](n1,n2));
    return 0;
}

int copy(int a,int b){
    return a;
}
int not(int a,int b){
    return ~a;
}

int suma(int a,int b){
    return a+b;
}
int and(int a,int b){
    return a & b;
}


int potencia(int base, int exponente) {
    int resultado = 1;
    for (int i = 0; i < exponente; i++) {
        resultado *= base;
    }
    return resultado;
}

int toNumber(char *num){
    int len = strlen(num);
    int c,pos,suma=0;
    for (int i=0;i<len;i++){
        c = *(num+i);
        c = c - '0'; // mascara?
        pos = len - (i+1);
        c = c * (potencia(10,pos)); 
        suma +=c;
    }
    return suma;
}