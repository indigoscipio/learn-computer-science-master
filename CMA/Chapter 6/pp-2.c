#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"

=============================================================
PP2

Write a program that asks the user to enter two integers, then calculates and displays their
greatest common divisor (GCD):
Enter two integers: 12 28
Greatest common divisor: 4

Hint: The classic algorithm for computing the GCD. known as Euclid’s algorithm, goes as
follows:

Let m and n be variables containing the two numbers.
If n is 0, then stop: m contains the GCD.
Otherwise, compute the remainder when m is divided by n.
Copy n into m and copy the remainder into n.
Then repeat the process,starting with testing whether n is 0.


*/

#include <stdio.h>

int main(void) {
    int m, n, rem;

    printf("Enter two integers: \n");
    scanf("%d %d", &m, &n);

    /*
    //method 1: while
    int new_n, new_m;
    while(n != 0){
        // n becomes new m
        // remainder becomes new n
        rem = m % n;
        m = n;
        n = rem;
    }
    // m contains the gcd
    printf("Greatest common divisor is: %d", m);
    */

    /*
    //method2: for
    for(;;){
        if(n == 0){
            printf("Greatest common divisor is: %d", m);
            break;
        }
        rem = m % n;
        m = n;
        n = rem;
    }
    */

    //method 3: do/while
    do{
        if(n == 0){
            printf("Greatest common divisor is: %d", m);
            break;
        }
        rem = m % n;
        m = n;
        n = rem;

    }while(n!=0);
    printf("Greatest common divisor is: %d", m);


    return 0;
}
