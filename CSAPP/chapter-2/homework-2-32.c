#include <stdio.h>
#include <stdbool.h>

/*
Home work problem 2.32
Writeaprocedureis_little_endianthatwillreturn1whencompiledandrunonalittle-endianma
chine,andwillreturn0whencompiledandrunonabig-endianmachine.Thisprogramshouldrunonany
machine,regardlessofitswordsize.

answer: ok let me thnk
we want a program that checks if a system is little endian or big endian

so if we have smth like
00 0f -> big endian
0f 00 -> little endian
and we want to run in any machine

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
