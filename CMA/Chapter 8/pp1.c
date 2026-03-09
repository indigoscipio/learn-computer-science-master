#include <stdio.h>

/*
PP1

Modify the repdigit ,c program of Section 8.1 so that it shows which digits (if any)
were repeated:

Enter a number: 939577
Repeated digit(s): 7 9

*/


#include <stdio.h>
#include <stdbool.h>
#define N 8

int main(void) {
    bool digit_seen[10] = {false};
    int digits[10] = {0,1,2,3,4,5,6,7,8,9};
    int digit, i;
    long n;

    printf("Enter a number: ");
    scanf("%ld", n);


    while(n>0){
        digit = n % 10;
        if(digit_seen[digit]){
            break;
        }
        digit_seen[digit] = true;
        n /= 10;
        }



    if(n > 0){
        printf("Repeated digit(s): \n");
    }else{
        printf("No repeated digits\n");
    }

    return 0;
}

/*
    // find the seen digits, iterate through the digit_seen and check for true value
    // match it up with the digit array
    for(i=0;i<10;i++){
        if(digit_seen[i]){
            printf("%d", digits[i]);
        }
    }

    */
