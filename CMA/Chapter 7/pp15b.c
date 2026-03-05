#include <stdio.h>

/*

PP15
Write a program that computes the factorial of a positive integer:

Enter a positive integer: 6
Factorial of 6: 720

then
(a) Use a short variable to store the value of the factorial. What is the largest value of n;
for which the program correctly prints the factorial of n?
(b) Repeat part (a), using an int variable instead.
(e) Repeat part (a), using a long variable instead.
(d) Repeat part (a), using a long long variable instead (if your compiler supports the
long long type).
(e) Repeat part (a), using a float variable instead.
(f) Repeat part (a), using a double variable instead.
(g) Repeat part (a), using a long double variable instead.
In cases (e)-(g). the program will display a close approximation of the factorial, not neces
sarily the exact value.

answer:

a) seems to stop at factorial n = 8, n = 7 still works - so somewhere between 32k
b) seeoms to stop at n = 17 (overvlow at around 2 billion), still works at n = 16
c) same as C
d) long long breaks at n = 21 (-4....) but n=20 still works
e) seems to work at n = 34, but when it reaches n = 35 it says "inf"
f) double breaks at n = 171, works at n = 170
g) not sure what it shows here inmine it just return 0.000000

*/


#include <stdio.h>

int main(void) {
    int num_input, n;
    long double fact = 1.00;

    printf("Enter a positive integer: \n");
    scanf("%d", &num_input);


    /*
    // FOR
    for(n = 1; n <= num_input; n++){
        fact *= n;
    }
    */

    // WHILE
    n = num_input;
    while(n > 0){
        fact *= n;
        n--;
    };


    printf("Factorial of %d is: %Lf", num_input, fact);

    return 0;
}
