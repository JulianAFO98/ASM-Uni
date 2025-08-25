/*
18. Realizar una función en C para pasar un string ASCII a un integer, utilizando máscaras (no
utilizar funciones de librerías como atoi()).
*/
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

int toNumber(char *num);
int potencia(int base, int exponente);

int main(int argc, char const *argv[])
{
    char num[] = "98";
    int n;
    n = toNumber(num);
    printf("%d",n);
    return 0;
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