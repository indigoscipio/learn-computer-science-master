#include <stdio.h>
#include <stdbool.h>

/*
Home work problem 2.34
Usingonlybit-levelandlogicaloperations,writeCexpressionsthatyield1forthedescribedconditionand
0otherwise.Yourcodeshouldworkonamachinewithanywordsize.Assumexisaninteger.

a. any bit of x equals 1
b. any bis of x equals 0
c. any bit in the lsb of x equals 1
d. any bit in the lsb of x equals 0

answer:
since we know in c 0 is false and everyting is true
*/

// PART A
// any bit of x equals 1
bool fun1(int x){
    //just check if x is nonzero
    return !(!x);
}

// PART B
// any bit of x equal 0
bool fun2(int x){
    //check if x is zero
    return !(!~x);
}

// PART C
// any bit in the LSB of x equals 1
bool fun3(int x){
    return !(!(0x000000FF & x));
}

// PART D
// any bit in the LSB of x equals 0
bool fun4(int x){
    //
    return !(!(0x000000FF & ~x));
}


int main(void){

    printf("%d", fun1(2));

    return 0;
}
