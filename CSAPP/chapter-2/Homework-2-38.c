#include <stdio.h>
#include <stdbool.h>

/*
Homework Problem 2.38 [Category 1]:
Fill in the following table showing the effects of complementing and incrementing several 5-bit vectors, in
the style of Figure 2.20. Show both the bit vectors and the numeric values.

x->          ~x->      incr(~x->)
[01101]       ?         ?
[01111]       ?         ?
[11000]       ?         ?
[11111]       ?         ?
[10000]       ?         ?


answer:

x->          ~x->           incr(~x->)
[01101]       [10010]       [10011]
[01111]       [10000]       [10001]
[11000]       [00111]       [01000]
[11111]       [00000]       [00001]
[10000]       [01111]       [10000]

now translateing
since this is 5bit
row 1
[01101] -> 8 + 4 + 1 = 13
[10010] -> -16 + 2 = - 14
[10011] -> - 16 + 2 + 1 = -13

row 2
[01111] -> 8+4+2+1 = 15
[10000] -> -16
[10001] -> -15

row 3
[11000] -> -16 + 8 = -8
[00111] -> 4 + 2 + 1 = 7
[01000] -> 8

row 4
[11111] -> -1
[00000] -> 0
[00001] -> 1

row 5
[10000] -> -16
[01111] -> 8 + 4 + 2 + 1 = 15
[10000] -> -16


*/


int main(void){
    return 0;
}
