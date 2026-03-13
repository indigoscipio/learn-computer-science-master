/*
PP11
Modify Programming Project 4 from Chapter 7 so that the program labels its output:

Enter phone number: 1- 800- COL- LECT
In numeric form: 1- 800- 265- 5328

The program will need to store the phone number (either in its original form or in its
numeric form) in an array of characters until it can be printed. You may assume that the
phone number is no more than 13 characters long.
*/


#include <stdio.h>
#include <ctype.h>

int main(void) {
    char ch;
    char input_arr[15] = {0};
    char output_arr[15] = {0};
    int i,j,k;

    printf("Enter a phone numher: \n");
    ch = getchar();

    i = 0;
    // STORE INPUT
    while(ch != '\n'){
        input_arr[i] = ch;
        i++;
        ch = getchar();
    }

    char ch1;
    //STORE IN OUTPUT
    for(j=0;j<i;j++){
        ch1 = input_arr[j];
        if(ch1 == 'A' || ch1 == 'B' || ch1 == 'C'){
            output_arr[j] = '2';
        }else if (ch1 == 'D' || ch1 == 'E' || ch1 == 'F'){
           output_arr[j] = '3';
        }else if (ch1 == 'G' || ch1 == 'H' || ch1 == 'I'){
            output_arr[j] = '4';
        }else if (ch1 == 'J' || ch1 == 'K' || ch1 == 'L'){
            output_arr[j] = '5';
        }else if (ch1 == 'M' || ch1 == 'N' || ch1 == 'O'){
            output_arr[j] = '6';
        }else if (ch1 == 'P' || ch1 == 'R' || ch1 == 'S'){
            output_arr[j] = '7';
        }else if (ch1 == 'T' || ch1 == 'U' || ch1 == 'V'){
            output_arr[j] = '8';
        }else if (ch1 == 'W' || ch1 == 'X' || ch1 == 'Y'){
            output_arr[j] = '9';
        }
        else{
            output_arr[j] = ch1;
        }
    }

    //PRINT OUTPUT
    for(k=0;k<i;k++){
        printf("%c", output_arr[k]);
    }

    return 0;
}
