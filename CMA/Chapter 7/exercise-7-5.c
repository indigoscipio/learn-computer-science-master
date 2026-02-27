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

Which one of the following is not a legal way to write
the number 65? assume that the character set is ASCII.

a. 'A'
b. 0b1000001
c. 0101
d. 0x41

answer:
a. this is legal since int 'A' = 65
b. binary of 7 bit = 65 so its also corect dpeending on what  version of c classic c does not suport
c. octal - 1 . 8^2 + 0 . 8^1 + 1 . 8^0 = 64 + 1 = 65 - therefore correct/legal
d. hex - 4 . 16^1 + 1 . 16^0 = 64 = 1 = 65 therefore legal/corect


therefore all of this is legal

*/


#include <stdio.h>

int main(void) {


    int n = 'A';

    printf("%d", n);

    return 0;
}
