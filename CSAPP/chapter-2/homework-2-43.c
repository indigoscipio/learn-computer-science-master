#include <stdio.h>
#include <stdbool.h>

/*
Homework Problem 2.43 [Category 2]:
Suppose we number the bytes in a w-bit word from 0 (least significant) to w=8 1 (most significant). Write
code for the following C function, that will return an unsigned value in which byte i of argument x has
been replaced by byte b.
unsigned replace_byte (unsigned x, int i, unsigned char b);
Here are some examples showing how the function should work
replace_byte(0x12345678, 2, 0xAB)--> 0x12AB5678
replace_byte(0x12345678, 0, 0xAB)--> 0x123456A

answer:
*/

replace_byte(unsigned x, int i, unsigned char b){
    //make a mask

    return (~(0xFF << i*8) & x) | b << i*8


}


int main(void){
    return 0;
}
