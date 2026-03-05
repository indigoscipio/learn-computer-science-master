#include <stdio.h>

/*

IMPORTANT
an array with N element has an index range from 0 to (N - 1)

*/


#include <stdio.h>
#include <stdbool.h>

#define N 5

int main(void) {

    /*
    //REVERSE ARRAY
    int a[N], i;

    printf("Enter %d numbers: ", N);

    for(i = 0 ; i < N; i++){
        scanf("%d", &a[i]);
    }

    printf("In reverse order: \n");
    for(i = N - 1; i >= 0; i--){
        printf(" %d", a[i]);
    }
    printf("\n");
    */


    /*
    //REPDIGIT
    bool digit_seen[10] = {false};
    int digit;
    long n;

    printf("Enter a number: \n");
    scanf("%ld", &n);

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
    */



    //COMPUTE INTREST
    #define NUM_RATES ((int) sizeof(value)/sizeof(value[0]))
    #define INITIAL_BALANCE 100.00

    int i, low_rate, num_years, year;
    double year[5];

    printf("")


    return 0;
}
