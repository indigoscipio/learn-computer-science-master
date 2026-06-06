#include <stdio.h>
#include <stdbool.h>

/*
Homework Problem 2.42 [Category 2]
Write C expressions to generate the following bit patterns, where ak represents k repetitions of symbol a.
Assume a w-bit data type. Your code may contain references to parameters j and k, representing the values
of j and k, but not a parameter representing w

a. 1^2-k 0^k
b. 0^w-k-j 1^k 0^j

answer:
1^k -> digit 1 repeated k times
0^k -> digit 0 repeated k times
w -> total width of data type

part a ->  w=8 (8bit data) and k=3 -> 11111000
((1 << k) - 1) << j

*/

// PART A
void fun1(int j, int k){
        // mask of all 1s
        // shift left by k
        return ~0 << k
    }

void fun2(int j, int k){
    // create first block
    // slide the block
    return ((1 << j) - 1) << j
}

int main(void){

    printf("%d\n", multiply_int_k5(5));
    printf("%d\n", multiply_int_k9(5));
    printf("%d\n", multiply_int_k14(10));
    printf("%d\n", multiply_int_kneg56(10));


    return 0;
}
