/*
PP7
The power function of Section 9.6 can be made faster by having it calculate.v" in a differ
ent way. We first notice that if /; is a power of 2. then .v" can be computed by squaring. For
example,.vJ is the square of.r.so v4 can be computed using only two multiplications instead
of three. As it happens, this technique can be used even when /; is not a power of 2. II /; is
even, we use the formula.v" = (,
v"/2 ):. If /; is odd. then ,
v" =.v x x"~'. Write a recursive func
tion that computes.v". (The recursion ends when n = 0. in which case the function returns I .)
To test your function, write a program that asks the user to enter values for .v and /;
. calls
power tocompute,
v", and then displays the value returned by the function

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

long int expt(int base, int power){
    if(power == 0){
        return 1;
    }else if(power % 2 == 0){
        //even
        long int result = expt(base, power/2);
        return result * result;
    }else{
        //odd
        return base * expt(base, power-1);
    }
}



int main(void) {
    int base;
    int power;

    printf("Enter your base number: ");
    scanf("%d", &base);

    printf("Enter your power: ");
    scanf("%d", &power);

    printf("The result is: %ld", expt(base,power));

    return 0;
}
