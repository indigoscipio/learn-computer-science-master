#include <stdio.h>

/*
PP3

Modify the repdigit .c program of Section 8.1 so that the user can enter more than one
number to be tested for repeated digits.The program should terminate when the user enters
a number that’s less than or equal to0.


*/


#include <stdio.h>
#include <stdbool.h>
int main(void) {
    bool digit_seen[10] = {false};
    int digit, i;
    long n, input_n;

    do{
        printf("Enter a number: \n");
        scanf("%ld", &input_n);
        if(input_n <=0) break;

        n = input_n;
        while(n>0){
            digit = n % 10;
            if(digit_seen[digit]){
                break;
            }
            digit_seen[digit] = true;
            n /= 10;
        }

        if(n > 0){
            printf("Repeated digit\n");
        }else{
            printf("No repeated digits\n");
        }

        //clean dhe digit array
        for(i=0;i<10;i++){
            digit_seen[i] = false;
        }

        //clean the int and n
    }while(input_n > 0);

    return 0;
}
