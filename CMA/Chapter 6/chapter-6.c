#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

*/

#include <stdio.h>

int main(void) {

    /*
    int n, sum = 0;

    printf("Enter integers (0 to terminate): \n")
    scanf("%d", &n);
    while(n != 0){
        sum += n;
        scanf("%d", &n);
    }
    printf("The sum is: %d\n", sum);
    */

    int i = 10;
    do{
        printf("T minus %d and counting\n", i);
        i--;
    } while(i > 0);


    return 0;
}
