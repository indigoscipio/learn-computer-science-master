#include <stdio.h>

/*

PP11
Write a program that takes a first name and last name entered by the user and displays the
last name, a comma, and the first initial, followed by a period:

Enter a first and last name: Lloyd Fosdick
Fosdick, L.

The user's input may contain extra spaces before the first name, between the first and last
names, and after the last name.

*/


#include <stdio.h>

int main(void) {
    char first_initial, last_initial, ch;

    printf("Enter a first a last name: \n");

    // skip leading space
    while((first_initial = getchar()) == ' ');

    //skip first name until it reaches space
    while(getchar() != ' ');

    // skip leading space again
    while((last_initial = getchar()) == ' ');
    printf("%c", last_initial);

    // start of last name, print the rest
    while((ch = getchar()) != '\n' && ch != ' '){
        printf("%c",ch);
    }

    // print first char
    printf(", %c", first_initial);


    return 0;
}
