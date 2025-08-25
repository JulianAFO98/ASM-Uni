
/*
Realizar una función en C en la cual ingresa un valor entero de 2 bytes (short int),
donde se codifica una fecha, e imprima la misma en formato ISO 8601 (YYYY-MM-DD).
Los 2 bytes (16 bits) se utilizan del siguiente modo para codificar la fecha: los 5 bits más
significativos para el día (de 1 a 31), seguidos de 4 bits para el mes (de 1 a 12) y los 7 bits
menos significativos para el año (de 0 a 99). Si el año es mayor a 50, se asume que está
entre 1950 y 1999, si es menor a o igual a 50, se considera como del 2000 al 2050.
*/

#include <stdint.h>
#include <stdlib.h> 
#include <stdio.h>
#define MAX16 15

void printBinary16(uint16_t n);
void weekday_set(char * c,int n);
void weekday_reset(char * c,int n);
void weekday_toggle(char *c, int n);
void printFecha(short int fecha);

int main(int argc, char const *argv[])
{
    short int fecha = 0b0111110001100011;
    printFecha(fecha);

    return 0;
}

void printFecha(short int fecha){
    short int dia,mes,anio;
    dia = fecha >> 11;
    mes = (fecha >> 7) & 0xF;
    anio = fecha & 0x7F;
    printf("%s%d-%d-%d",anio<50?"20":"19",anio,mes,dia);
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