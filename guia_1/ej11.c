
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
void repBin16(int nro,char *s);

int main(int argc, char const *argv[])
{
    int nro = 15; // cambiar por -15 para hacer el ej 12
    char s[17];
    repBin16(nro,s);
    printf("%X = %s", nro, s);
    return 0;
}

void repBin16(int nro,char *s){ // modificable para 32 o 64
    int i = MAX16;
    while(i>=0){
        *(s+i) = ((nro >> MAX16-i) & 0x1) + '0';
        i--;
    }
    s[16] = '\0';
    printf("%s\n",s);
}
