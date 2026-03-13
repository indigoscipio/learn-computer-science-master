/*
PP13
Modify Programming Project 11 from Chapter 7 so that the program labels its output:

Enter a first and last name: Lloyd Fosdick
You entered the name: Fosdick, L.

The program will need tostore the last name (but not thefirst name) in an array of characters
until it can be printed. You may assume that the last name is no more than 20 characters long.
*/


#include <stdio.h>
#include <ctype.h>

int main(void) {
    char lastname[20] = {};
    char first_initial, last_initial;

    printf("Enter a first a last name: \n");

    // skip leading space
    while((first_initial = getchar()) == ' ');

    //skip first name until it reaches space
    while(getchar() != ' ');

    // skip leading space again
    while((last_initial = getchar()) == ' ');
    printf("%c", last_initial);

    //start of last name
    int i;



    return 0;
}
