/*
16. Realizar una función en C que reciba día, mes y año como parámetros enteros y devuelva
un short int con la fecha codificada al igual que en el ejercicio anterior.
*/

#include <stdint.h>
#include <stdlib.h> 
#include <stdio.h>
#define MAX16 15

short int unirFecha(short int dia,short int mes,short int anio);



int main(int argc, char const *argv[])
{
    short int dia=15,anio=99,mes=8;
    printf("La fecha entera es:%d\n",unirFecha(dia,mes,anio));
    return 0;
}


short int unirFecha(short int dia,short int mes,short int anio){
    short int fecha = 0x0;
    fecha = fecha | anio;
    fecha = fecha | (mes << 7);
    fecha = fecha | (dia << 11);
    return fecha;
}