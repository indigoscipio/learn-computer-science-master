#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"

=============================================================
PP4

Write a program that prompts the user to enter a number n. then prints all even squares
between I and n. For example, if the user enters 100. the program should print the following:

4
16
36
64
100

*/

#include <stdio.h>

int main(void) {
    int i, n, n_squared = n * n;

    printf("Find all even squares between 1 - n. Enter a number: \n");
    scanf("%d",&n);

    /*
    //v1
    for(i=1 ; n<n_squared ; i++){
        if(i%2 != 0){
            continue;
        }
        n =  i * i;
        printf("%d\n", n);
    }
    */

    /*
    //v2
    //store the sum in the index
    for(i=2; i*i<=n ; i+=2){
        printf("%d\n",i*i);
    }
    */

    //v3
    i = 2;
    while(i*i<=n){
        printf("%d\n", i*i);
        i+=2;
    }


    return 0;
}
