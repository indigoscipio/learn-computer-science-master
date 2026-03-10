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
int main(void) {
    int digit_counts[10] = {0};
    int digit, i;
    bool has_repeat = false;
    long n;

    printf("Enter a number: \n");
    scanf("%ld", &n);

    while(n>0){
        digit = n % 10;
        digit_counts[digit]++;
        n /= 10;
    }

    for(i=0;i<10;i++){
        //found a repeat
        if(digit_counts[i] > 1){
            if(!has_repeat){
                    printf("Repeated digit(s):");
                    has_repeat = true;
            }
                    printf("%d",i);
        }
    }

    if(!has_repeat) printf("No repeats");

    return 0;
}
