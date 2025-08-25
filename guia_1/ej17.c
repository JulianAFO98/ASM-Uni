/*
Realizar una función en C para pasar un string ASCII a mayúsculas, utilizando máscaras y
aprovechando la codificación ASCII (no utilizar la función de librerías como toupper() o
strupr()).
*/
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

void miupper(char *s){
    for(int i = 0;i<strlen(s);i++){
        *(s+i) = *(s+i) & ~(1 << 5);
    }
}

int main(int argc, char const *argv[])
{
    char pal[] = "Hola";
    miupper(pal);
    printf("%s\n",pal);
    return 0;
}

