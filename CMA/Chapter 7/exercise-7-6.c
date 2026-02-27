#include <stdio.h>

/*
by default C uses signed integer

float = only 6 digits
double = upto 15 digits decimal

ASCII are just numbers
char a
a = 'a'

TYPES
Integral types
char
signed int
unsigned int

Floating
float
double

Type conversion
c always promote the lower one
c force signed -> unsigned conversion

Ranking System
ll int
l int
int
short int
char
bool

7.6
for each of the folowing items of data specify which one of the types char, short, int
or long is the smallest one guaranteed to be large enough to store the item

a. days in a month
b. days in a year
c. minutes in a day
d. seconds in a day

answer:
a. we days inamonth is 1 - 31 so char is smallest to store the largest
b. range is 1 - 365 so need to use short
c. 1440 is the max range so short
d. max is 86400 so use long int

*/


#include <stdio.h>

int main(void) {


    int n = 'A';

    printf("%d", n);

    return 0;
}
