#include <stdio.h>

typedef unsigned char *byte_pointer;

void show_bytes(byte_pointer start, int len){
    int i;
    for(i=0;i<len;i++)
        printf(" %.2x", start[i]); //print actual data value inside that address
    printf("\n");
}

void show_int(int x){
    show_bytes((byte_pointer) &x, sizeof(int));
}

int main(void){

    show_int('A');

    return 0;
}
