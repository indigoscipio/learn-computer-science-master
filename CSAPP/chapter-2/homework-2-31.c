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

void show_short(short int n){
    show_bytes((byte_pointer )&n, sizeof(short int));
}

void show_long(long int n){
    show_bytes((byte_pointer) &n, sizeof(long int));
}

void show_double(double d){
        show_bytes((byte_pointer) &d, sizeof(double));;
}

int main(void){
    short int s = 32;
    long int l = 12345678987654321;
    double d = 1.23e20;

    show_short(s);
    show_long(l);
    show_double(d);

    return 0;
}
