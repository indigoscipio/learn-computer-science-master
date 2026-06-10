#include <stdio.h>
#include <stdbool.h>

/*
Homework Problem 2.46
Consider numbers having a binary representation consisting of an infinite string of the form 0:yyyyyy ,
where y is a k-bit sequence. For example, the binary representation of 1
3
is 0:01010101
the representation of 1
5
is 0:001100110011
= 0011).
A. Let Y = B2Uk(y), that is, the number having binary representation y. Give a formula in terms of Y
and k for the value represented by the infinite string. [Hint: Consider the effect of shifting the binary
point k positions to the right.]

B. What is the numeric value of the string for the following values of y?
a. 001
b. 1001
c. 000111

A.
2^k . x = Y + x
2^k . x - x = Y
x(2^k - 1) = Y
x = y / 2^k-1

B.

a. 001
k block = 3
Y = 1

x = 1/2^3 - 1 = 1/8-1 = 1/7

b.1001
k block = 4
Y = 9

x = 9/2^4 - 1 = 9/15

c. 000111
k block = 6
Y = 7

x = 7/2^6 - 1 = 7/63


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
