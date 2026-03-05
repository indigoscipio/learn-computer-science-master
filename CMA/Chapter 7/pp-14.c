#include <stdio.h>

/*

PP14
Write a program that uses Newton’s method to compute the square root of a positive float
ing-point number:
Enter a positive number: 3
Square root: 1.73205
Let .v be the number entered by the user. Newton’s method requires an initial guess y for the
square root of.v (we’ll use y = I ). Successive guesses arc found by computing the average of
y and x/y. The following table shows how the square root of 3 would be found:
x
3
y
3 2
3 1.75
x/y
3
1.5
1.71429
Average of
y and x/y
2
1.75
1.73214
3 1.73214 1.73196 1.73205
3 1.73205 1.73205 1.73205
Note that the values of v get progressively closer to the true square root of x. For greater
accuracy, your program should use variables of type double rather than float. Have the
program terminate when the absolute value of the difference between the old value of y and
the new value of y is less than the product of .00001 and y. Hint: Call the f abs function to
find the absolute value of a double. (You'll need to include the <math.h> header at the
beginning of your program in order to use f abs.)
*/


#include <stdio.h>
#include <math.h>

int main(void) {
    double x, y = 1.0, old_y, new_y, result;

    printf("Enter a positive float: \n");
    scanf("%lf", &x);

    do{
        //save curr y into old y
        old_y = y;
        // calc new avg, update y
        new_y = ((x / y) + y) / 2;
        y = new_y;
    }while(fabs(old_y - new_y) >= (0.00001 * new_y));

    printf("Square root: %lf", new_y);

    return 0;
}
