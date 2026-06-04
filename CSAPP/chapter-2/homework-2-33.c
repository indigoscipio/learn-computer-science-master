#include <stdio.h>
#include <stdbool.h>

/*
Home work problem 2.33
WriteaCexpressionthatwillyieldawordconsistingoftheleastsignificantbyteofx,andtheremaining
bytesofy.Foroperandsx=0x89ABCDEFandy=0x76543210,thiswouldgive0x765432EF

answer:

ok so i think we need bit masking for this one

x=0x89ABCDEF
y=0x76543210

we want to keep the LSB of x and just replace the whole x with y
x=00000000EF
y=0x76543210

so last byte EF is still there
so maybe we can use like a or here? not sure how to mask it


; isolate x LSB
; 0x89ABCDEF & 0x000000FF

; isolate y head (excluding lsb)
0x76543210 & 0xFFFFFF00

; combine
printf("%x", 0x89ABCDEF & 0x000000FF | 0x76543210 & 0xFFFFFF00);



*/

typedef unsigned char *byte_pointer;

void show_bytes(byte_pointer start, int len){
    int i;
    for(i=0;i<len;i++)
        printf(" %.2x", start[i]); //print actual data value inside that address
    printf("\n");
}


bool is_little_endian(void){
    int test = 1;
    byte_pointer bp = (byte_pointer) &test;
    return bp[0];
}


int main(void){

    printf("%d", is_little_endian());

    return 0;
}
