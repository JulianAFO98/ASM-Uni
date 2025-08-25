/*
 Realizar programa en C para cifrar/descifrar un archivo TXT con una palabra clave pasada
por parámetro (NOTA: el archivo debe abrirse como binario). El programa debe recibir por
parámetros la palabra clave, el archivo origen y el archivo destino. El cifrado debe hacerse
byte a byte con cada byte del archivo y la palabra utilizando xor (^) (la palabra se utiliza
cíclicamente).
Probar el programa creando un archivo de texto y pasarlo dos veces por el programa
utilizando la misma palabra clave.

*/

#include <stdlib.h>
#include <stdio.h>


int main(int argc, char  *argv[])
{   
    int c,i=0,len=0;
    char *s = argv[1];
    char *nombreArchivo = argv[2];
    char *nombreArchivoDestino = argv[3];

    FILE *arch = fopen(nombreArchivo,"rb");
    FILE *archDestino = fopen(nombreArchivoDestino,"wb");

    if(arch == NULL) {
        printf("El archivo no existe");
    }else{
        while(s[len] != '\0') len++;
        while((c = fgetc(arch))!=EOF){
            fputc(c ^ s[i],archDestino);
            i = (i + 1) % len;
        }
        fclose(arch);
    }
    fclose(archDestino);
    return 0;
}
