
/*
11) Realizar una función en C, que reciba como parámetro un número entero (int nro) y un
string (char* s), y rellene el string con los caracteres ‘1’ o ‘0’ con la representación binaria
del número entero. Debe realizar la función utilizando máscaras y desplazamientos.
a. Verifique el resultado comparado con su representación hexadecimal
printf(“%X = %s”, nro, s);

*/

#include <stdint.h>
#include <stdlib.h> 
#include <stdio.h>
#define MAX16 15

void mostrarDias(char c);
void printBinary16(uint16_t n);

int main(int argc, char const *argv[])
{
    char c = 0b00001010;
    mostrarDias(c);
    return 0;
}

void mostrarDias(char c){
    char mascara = 0b00000001;
    for(int i = 6;i>=0;i--){
        char dia = c & mascara;
        switch (dia)
        {
        case 0b00000001:
            printf("Domingo\n");
            break;
        case 0b00000010:
            printf("Lunes\n");
            break;
        case 0b00000100:
            printf("Martes\n");
            break;
        case 0b00001000:
            printf("Miercoles\n");
            break;
        case 0b00010000:
            printf("Jueves\n");
            break;
        case 0b00100000:
            printf("Viernes\n");
            break;
        case 0b01000000:
            printf("Sabado\n");
            break;
        }
        mascara = mascara << 1;
    }

}

void printBinary16(uint16_t n) {
    for (int i = 15; i >= 0; i--) {              
        printf("%d", (n >> i) & 1);              
        if (i % 4 == 0 && i != 0) printf(" ");  
    }
    printf("\n");
}