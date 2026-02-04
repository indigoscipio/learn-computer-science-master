#include <stdio.h>
/*
Exercise 4
Write a program that computes the volume of a sphere with a 10-meter radius, using the for
mula v= 4/3Jtr\ Write the fraction 4/3 as 4 .Of /3.Of. (Try writing it as 4/3. What hap
pens?) Hint: C doesn’t have an exponentiation operator, so you'll need to multiply r by itself
twice to compute r.
*/

int main(void){
    float radius = 10;
    float pi = 3.14159f;


    printf("The volume of the sphere is: %f", ((4.0f / 3.0f) * pi * (radius * radius * radius)));

    return 0;
}
