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

Which of the following are not legal types in c?
a. short unsigned int
b. short float
c. long double
d. unsigned long

answer:
a. int can be short and unsigned so its legal
b. i don't think float can be long or short its just float so its not legal
c. double can be modified by long to increase higher precision
d. legal same as unsigned long int

*/

#include <stdio.h>

int main(void) {

    unsigned long n = 10E2;

    printf("%f", n);

    return 0;
}
