 /*
CHAPTER 13: Strings

STRING LITERAL
"this is a string"
like racket but iwth \0 to seperate
we can't modifiy it - read only!

DONT change a string literal
char *p = "abc"
*p = 'd'

SINGLE CHAR STRING LITERAL
"a" vs 'a'

INITIALIZATION
just use a[unspeficied] = "STRING" for safety

CHAR VS ARR POINTER
*date = "June 13" -> cannot be modiifed - string literal!
date[] = "June 13" -> can be modified - make a copy

ILEGAL
str1 = "abc"
str2 = str1


'\0' is the same as 0 int
'\0' is FALSE
*p = *s2
if *p = '\0' this is treated as false

putchar -> can take string pointer or char
puts -> can take string literal or string piointer

pointer to string always give exactly one character
*p = "abc"
*p -> a'

STRCPY
replaces the destination with source
depends on the source lenght
if source < destination source wins.
can accept char memory address eg &str[4]
In C, strcpy (string copy) doesn't want the actual character data passed directly to it.
Instead, it needs to know where the data is.

STRCAT
finds the first null char ('\0') and replaces it with arg

INC C, a string and a pointer/address ARE THE SAME THING
char s1[] = "computer"
strcpy(q, s1)

String name = address of first char
strcpy, strlen, strcat all expect addresses, not characters



============================================

Programming Project 2
Improve the remind.c program of Section 13.5 in the following ways:
a. Have the program print an error message and ignore a reminder if the corresponding
day is negativeor larger than 31. Hint: Use the continue statement.
b. Allow the user to enter a day.a 24-hour time, and a reminder. The printed reminder list
should be sorted first by day, then by time. (The original program allows the user to
enter a time, but it's treated as pan of the reminder.)
c. Have the program print a one-year reminder list. Require the user to enter days in the
form month/day.

answer:
lets keep this simple
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>

#define MAX_REMIND 50
#define MSG_LEN 60

int read_line(char str[], int n);

int read_line(char str[], int n)
{
    int ch, i = 0;

    while ((ch = getchar()) != '\n' && ch != EOF) {
        if (i < n)
            str[i++] = ch;
    }
    str[i] = '\0';
    return i;
}

int main(void){
    char reminders[MAX_REMIND][MSG_LEN + 8];
    char day_str[3], time_str[6], msg_str[MSG_LEN + 1];
    int day, hour, minute, i, j, num_remind = 0;

    for (;;) {
        if (num_remind == MAX_REMIND) {
            printf("-- No space left--\n");
            break;
        }

        printf("Enter day and reminder: ");
        scanf("%2d%2d:%2d", &day, &hour, &minute);

        // print error
        if(day < 0 || day > 31){
            printf("Error: day must be posint <= 31!\n");
            read_line(msg_str, MSG_LEN);
            continue;
        }

        if (day == 0) break;

        sprintf(day_str, "%2d", day);
        sprintf(time_str, "%2d:%2d", hour, minute);
        read_line(msg_str, MSG_LEN);

        char day_time_str[9];
        strcpy(day_time_str, day_str);
        strcat(day_time_str, time_str);
        for (i = 0; i < num_remind; i++)
            if (strcmp(day_time_str, reminders[i]) < 0)
                break;

        for (j = num_remind; j > i; j--)
            strcpy(reminders[j], reminders[j - 1]);

        strcpy(reminders[i], day_time_str);
        strcat(reminders[i], msg_str);

        num_remind++;
    }

    printf("\nDay Reminder\n");

    for (i = 0; i < num_remind; i++)
        printf(" %s\n", reminders[i]);

    return 0;
}
