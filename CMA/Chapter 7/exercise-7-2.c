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

Which of the folowing are not legal constant in C?
classify each legal constant as either integer or floating point

a. 010E2
b. 32.1E+5
c. 0790
d. 100_000
e. 3.978e-2

answer:
a. this seems to be octal since it start with 0
type: floating point
exponent even if it start with 0

b. this looks like a scientific notation
type: floating point
32.1 . 10^5 so its legal

c. 0790
type: integer
also octal here but the limit is from 0 - 7 so its not legal

d. 100_000
integer but
i don't think this is legal since underscore it not integer?

e. 3.978e-2
floating point/scientific notation so its legal
3.978 . 10^-2

in c constant is octal if its 0 - 7
if it contains . or e/e it treats as floating point

*/

#include <stdio.h>

int main(void) {

    float n = 10E2;

    printf("%f", n);

    return 0;
}
