#include <stdio.h>

/*
PP2

Modify the repdigit.c program of Section 8.1 so that it prints a table showing how
many times each digit appears in the number:

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

    // Digit printer
    printf("Digit: \t\t");
    for(i=0;i<10;i++){
        printf("%d    ", i);
    }

    printf("\n");
    //Occurence pritner
    printf("Occurences: \t");
    for(i=0;i<10;i++){
        printf("%d    ", digit_counts[i]);
    }


    return 0;
}
