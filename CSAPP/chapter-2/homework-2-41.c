#include <stdio.h>
#include <stdbool.h>

/*
Homework problem 2.40
Suppose we are given the task of generating code to multiply integer variable x by various different constant
factors K. To be efficient we want to use only the operations +,-,and<<. For the following values of K,
write C expressions to perform the multiplication using at most three operations per expression.

a. k = 5
b. k = 9
c. k = 14
d. k = -56

answer:
*/


// PART A - k = 5
int multiply_int_k5(int x){
    //factor of 5 = 2^2 + 2^1 = 4 + 1
    return (x << 2) + x;
}

// PART B - k = 9
int multiply_int_k9(int x){
    //factor of 9 = 2^3 + 2^0
    return (x << 3) + x;
}

// PART C = k = 14
int multiply_int_k14(int x){
    //factor of 14 = 16 - 2 = 2^4 - 2^1
    return (x << 4) - (x << 1);
}

// PART D - k = -56
int multiply_int_kneg56(int x){
    // factor of -56 = -64 + 8 = -2^6 + 2^3
    return (x << 3) - (x << 6) ;
}


int main(void){

    printf("%d\n", multiply_int_k5(5));
    printf("%d\n", multiply_int_k9(5));
    printf("%d\n", multiply_int_k14(10));
    printf("%d\n", multiply_int_kneg56(10));


    return 0;
}
