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



    /*
    //COMPUTE INTREST
    #define NUM_RATES ((int) sizeof(value)/sizeof(value[0]))
    #define INITIAL_BALANCE 100.00

    int i, low_rate, num_years, year;
    double value[5]; //the row

    printf("Enter interest rate: ");
    scanf("%d", &low_rate);

    printf("Enter number of years: ");
    scanf("%d", &num_years);

    printf("\nYears");
    for(i=0; i < NUM_RATES ;i++){
        printf("%6d%%", low_rate + i);
        value[i] = INITIAL_BALANCE;
    }
    printf("\n");

    for(year = 1; year <= num_years; year++){
        printf("%3d      ", year);
        for(i = 0; i < NUM_RATES ; i++){
            value[i] += (low_rate + i) / 100.0 * value[i];
            printf("%7.2f", value[i]);
        }
        printf("\n");
    }
    */

    /*
    // identity matrix
    #define N 10
    double ident [N][N];
    int row, col;

    for(row = 0; row < N; row++){
        for(col = 0; col < N; col++){
            if(row==col){
                ident[row][col] = 1.0;
            }else{
                ident[row][col] = 0.0;
            }
        }
        printf("ROW%d\n", row);
    }
    */


    /*
    // CARD DEALING
    #include <stdbool.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <time.h>

    #define NUM_SUITS 4
    #define NUM RANKS 13

    bool in_hand[NUM_SUITS][NUM_RANKS] = {false};
    int num_cards, rank, suit;
    const char rank_code[] = {'2','3','4','5','6','7','8','9','t','j','q','k','a'};
    const char suit_code[] = {'c','d','h','s'};

    printf("Enter number of cards in hand: ");
    scanf("%d", &num_cards);

    printf("Your hand: ");
    while(num_cards>0){
        suit = rand() % NUM_SUITS //pick random suit
        rank = rand() % NUM_RANKS //pick random rank

        if(!in_hand[suit][rank]){
            in_hand[suit][rank] = true;
            num_cards--;
            printf(" %c%c", rank_code[rank], suit_code[suit]);
        }
    }
    printf("\n");
    */

    return 0;
}
