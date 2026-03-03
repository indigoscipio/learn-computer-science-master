#include <stdio.h>

/*

PP9
Write a program that asks the user for a 12-hour time, then displays the time in 24-hour
form: Enter a 12-hour time: 9:11 PM
Equivalent 24-hour time.- 21:11
See Programming Project 8 for a description of the input format.

*/


#include <stdio.h>
int main(void) {

    int h24, m24, h12, m12;
    char ch;

    printf("Enter a 12-hour time: ");
    scanf("%d:%d %c", &h12, &m12, &ch);

    h24 = h12;
    m24 = m12;
    // case for pm
    if ((ch == 'P' || ch == 'p') && h12 != 12) {
        h24 += 12;
    }
    // case for am
    else if ((ch == 'A' || ch == 'a') && h12 == 12) {
        h24 = 0;
    }

    printf("Equivalent 24-hour time is: %02d:%02d\n", h24, m24);

    return 0;
}
