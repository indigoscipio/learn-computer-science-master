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

7.13
Assume that a program contains the following declarations:
char c = '\l';
short s = 2;
int i =-3;
long m = 5;
float f = 6.5f;
double d = 7.5;

Give the value and the type of each expression listed below,
(a) c * i
(b) s + m
(c) f / c
(d) d / s
(e) f - d
(f) (int) f

answer:
a. 1 (char) * -3 (int) = -3 (int)
b. 2 (short int) + 5 (long) = 7 (long int)
c. 6.5 (float) / 1 (char) = 6.5.. (float)
d. 7.5 (double) / 2 (short) = 3.75.. (double)
e. 6.5 (float) - 7.5 (double) = -1.. (double)
f. (int) 6.5 (float) = 6 (int) - demoted since it has explicit cast

*/


#include <stdio.h>

int main(void) {


    float f = (int) 6.5f;

    printf("%d", f);

    return 0;
}
