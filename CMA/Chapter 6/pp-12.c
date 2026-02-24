#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"

=============================================================
PP12

Modify Programming Project 11 so that the program continues adding terms until the cur
rent term becomes less than e. where e is a small (floating-point) number entered by the
user.


*/

#include <stdio.h>

int main(void) {
    int n, fact = 1, i = 1;
    float total_sum = 1, curr_term, epsilon;

    printf("Enter your epsilon value: \n");
    scanf("%f", &epsilon);

    /*
    for(;;){
        fact*= i;
        curr_term = 1.0 / fact;

        if(curr_term < epsilon){
            break;
        }

        total_sum += curr_term;
        i++;
    }
    */

    curr_term = 1.0
    while(curr_term >= epsilon){
        fact*= i;
        curr_term = 1.0 / fact;

        total_sum += curr_term;
        i++;
    }

    printf("Your approximation is: %.2f", total_sum);

    return 0;
}
