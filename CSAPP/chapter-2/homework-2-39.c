#include <stdio.h>
#include <stdbool.h>

/*
Homework problem 2.39
Show that first decrementing and then complementing is equivalent to complementing and then increment
ing. That is, for any signed value x, the C expressions-x, ˜x+1,and˜(x-1)yield identical results. What
mathematical properties of two's complement addition does your derivation rely on?

answer:

ok lets start with a small example
lets ssay x = 3 and we have a 4bit word size

x -> 0011
-x = -3 = 1101
(~x)+1 = 1100 + 0001 = 1101
~(x-1) = ~(0011 - 0001) = ~(0010) = 1101

so all result is the same
now the question asks for mathematical property of the two complement addition
does the derivation rely on


~x = -x -1
~(x-1) = -(x-1) - 1 = -x

so -x = ~x + 1 = ~(x-1)
distributive and associative


*/


int main(void){
    return 0;
}
