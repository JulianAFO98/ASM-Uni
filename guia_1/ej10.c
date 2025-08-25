 #include <stdint.h>
 #include <stdlib.h>
 #include <stdio.h>

void printBinary16(uint16_t n);
int main(int argc, char const *argv[])
{
   
    int16_t n = 350;
    printBinary16(n); //0000 0001 0101 1110
    
    //a)
    //n = (n >> 8) & 0x00FF; 
    //printBinary16(n);  //0000 0000 0000 0001 
    //b)
    //n = n & 0x00FF;
    //printBinary16(n); // 0000 0000 0101 1110
    //c
    //n = n & 0x1;
    //printBinary16(n); // 0000 0000 0000 0000
    //d)
    //n = n >> 15;
    //printBinary16(n); // 0000 0000 0000 0000
    //e)
    //n = (n >> 4) & 0xFFF;
    //printBinary16(n);
    //f)
    n = n & 0xF;
    printBinary16(n);
    return 0;
}


void printBinary16(uint16_t n) {
    for (int i = 15; i >= 0; i--) {              
        printf("%d", (n >> i) & 1);              
        if (i % 4 == 0 && i != 0) printf(" ");  
    }
    printf("\n");
}