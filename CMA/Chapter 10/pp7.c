/*
PP7
Write a program that prompts the user for a number and then displays the number, using
characters to simulate the effect of a seven-segment display:
Enter a number: 491-9014
Characters other than digits should be ignored. Write the program so that the maximum
number of digits is controlled by a macro named MAX_DIGITS.which has the value 10. If

the numbercontains more than this number of digits,the extra digits are ignored. Hints: Use
twoexternal arrays. One is the segmentsarray (see Exercise 6in Chapter 8) . which stores
data representing the correspondence between digits and segments. The other array, dig
its. will be an array of characters with 4 rows (since each segmented digit is four charac
ters high) and MAX DIGITS * 4 columns (digits are three characters wide, but a space is
needed between digits for readability) . Write your program as four functions: main.
clear_digits_ array. process digit, and print digits array. Here are
the prototypes for the latter three functions:
void clear
_ digits_array(void) ;
void process
_ digit ( int digit, int position) ;
void print
_digits_array( void) ;
clear
_ digits
_ array will store blank characters into all elements of the digits
array. process
_ digit will store the seven-segment representation of digit into a
specified position in the digits array (positions range from 0 to MAX DIGITS-I ).
print
_digits_ arraywill display the rows of the digitsarray,
each on a single line,
producing output such as that shown in the example

*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

#define MAX_DIGITS 10
#define DIGITS 10
#define ROW_HEIGHT 4
#define SEG_COUNT 7

//EXTERNAL VARS
char segments[DIGITS][SEG_COUNT]={
    {1, 1, 1, 1, 1, 1, 0}, // Digit 0
    {0, 1, 1, 0, 0, 0, 0}, // Digit 1
    {1, 1, 0, 1, 1, 0, 1}, // Digit 2
    {1, 1, 1, 1, 0, 0, 1}, // Digit 3
    {0, 1, 1, 0, 0, 1, 1}, // Digit 4
    {1, 0, 1, 1, 0, 1, 1}, // Digit 5
    {1, 0, 1, 1, 1, 1, 1}, // Digit 6
    {1, 1, 1, 0, 0, 0, 0}, // Digit 7
    {1, 1, 1, 1, 1, 1, 1}, // Digit 8
    {1, 1, 1, 1, 0, 1, 1}, // Digit 9
};
char digits[ROW_HEIGHT][MAX_DIGITS*4];

//PROTOTYPES
void clear_digits_array(void);
void process_digit(int, int);
void print_digits_array(void);

void clear_digits_array(void){
    //loop through digits. clean it
    for(int i=0;i<ROW_HEIGHT;i++){
        for(int j=0; j<MAX_DIGITS*4;j++){
            digits[i][j] = ' ';
        }
    }
}

void process_digit(int digit, int position){
    int starting_col = position * 4;

    /*
    3x3
    Segment 0: Top horizontal (row 0, col 1);
    Segment 1: Upper-right vertical (row 1, col 2)
    Segment 2: Lower-right vertical (row 2, col 2)
    Segment 3: Bottom horizontal (row 2, col 1)
    Segment 4: Lower-left vertical (row 2, col 0)
    Segment 5: Upper-left vertical (row 1. col 0)
    Segment 6: Middle horizontal (row 1, col 1)
    */

    // correctly prints sgement
    if(segments[digit][0]){
        digits[0][starting_col+1] = '_';
    }if(segments[digit][1]){
        digits[1][starting_col+2] = '|';
    }if(segments[digit][2]){
        digits[2][starting_col+2] = '|';
    }if(segments[digit][3]){
        digits[2][starting_col+1] = '_';
    }if(segments[digit][4]){
        digits[2][starting_col] = '|';
    }if(segments[digit][5]){
        digits[1][starting_col] = '|';
    }if(segments[digit][6]){
        digits[1][starting_col+1] = '_';
    }
}

void print_digits_array(void){

}

//main: calls read_cards, analyze_hand and print_Result repeatedly
int main(void) {
    int n;

    clear_digits_array();

    //scan user input
    //printf("Enter a number: ");
    //scanf("%d", n);


    process_digit(1,0);
    process_digit(2,1);
    process_digit(3,2);




    //call print digit
    //for every digits print it
    for(int i=0;i<ROW_HEIGHT;i++){
        for(int j=0; j<MAX_DIGITS*4;j++){
            printf("%c",digits[i][j]);
        }
        printf("\n");
    }

    return 0;
}
