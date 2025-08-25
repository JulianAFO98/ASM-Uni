
/*
14. Realizar una función “weekday_set” en C que reciba como parámetros: un puntero a char
y un número entero (de 0 a 6), y que configure en 1 el bit correspondiente al día de la
semana (siendo 0 domingo y 6 sábado) como en el ejercicio anterior. Del mismo modo,
escribir una función “weekday_reset”, con los mismos parámetros, para configurar el bit en 0.

*/

#include <stdint.h>
#include <stdlib.h> 
#include <stdio.h>
#define MAX16 15

void printBinary16(uint16_t n);
void weekday_set(char * c,int n);
void weekday_reset(char * c,int n);
void weekday_toggle(char *c, int n);
int main(int argc, char const *argv[])
{
    char c = 0b0;
    int n = 4;
    weekday_set(&c,n);
    weekday_reset(&c,n);
    return 0;
}
void weekday_set(char * c,int n){
    *c = *c | (1 << n);
    printf("%X\n",*c);
}

void weekday_reset(char * c,int n){
    *c = *c  & ~(0b1 << n);
    printf("%X\n",*c);
}

void weekday_toggle(char *c, int n) {
    *c ^= (1 << n);
    printf("%X\n", *c);
}

void printBinary16(uint16_t n) {
    for (int i = 15; i >= 0; i--) {              
        printf("%d", (n >> i) & 1);              
        if (i % 4 == 0 && i != 0) printf(" ");  
    }
    printf("\n");
}