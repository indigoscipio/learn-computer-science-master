#include <stdio.h>
/*
PP 3
Modify the program of Programming Project 2 so that it prompts the user to enter the radius
of the sphere
*/

int main(void){
    float radius;
    float pi = 3.14159f;


    printf("Enter your sphere radius: ");
    scanf("%f", &radius);

    printf("Your sphere volume is: %.2f", ((4.0f / 3.0f) * pi * (radius * radius * radius)));
    return 0;
}
