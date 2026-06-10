#include <stdio.h>
#include <stdbool.h>

/*
Homework Problem 2.44
Fill in code for the following C functions. Function srl performs a logical right shift using an arithmetic
right shift (given by value xsra), followed by other operations not including right shifts or division. Func
tion sra performs an arithmetic right shift using a logical right shift (given by value xsrl), followed by
other operations not including right shifts or division. You may assume that int’s are 32-bits long. The
shift amount k can range from 0 to 31

unsigned srl(unsigned x, int k)
{
//Perform shift arithmetically
unsigned xsra = (int) x >> k;
//fill here
}

int sra(int x, int k)
{
// Perform shift logically
int xsrl = (unsigned) x >> k;
//fill here
}


answer:
*/

// PART A
unsigned sr1(unsigned x, int k){
    unsigned xsra = (int) x >> k;

    // arith shift
    // just pad with 0 ??

    return  ((1U << (31 - k)) << 1) - 1 & k;
}

//PART B
int sra (int x, int k){
    int xsr1 = (unsigned) x >> k;

    // find MSB
    // then pad it with that
}


int main(void){
    return 0;
}
