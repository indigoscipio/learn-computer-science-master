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

7.14
Does the following statement always compute the fractional part of f correctly
(assuming that f and frac_part are float variables)?

frac_part = f - (int) f;

If not, what’s the problem?

answer:
lets evaluate this
(int) f -> since we use explicit cast the float will get 'demoted' to int, dropping the decimals
then do the minus operation (float) - (int), which will result in a float
so frac_part will result in only the fractional part which have a float type

example: f = 5.5
5.5 - 5 -> 0.5
f = 9.75
9.75 - 9 -> 0.75

however if we test it in negative number
f = -5.5
-5.5 - (-5) = -5.5 + 5 = -0.5

which yields negative fractional




*/


#include <stdio.h>

int main(void) {


    float f = (int) 6.5f;

    printf("%d", f);

    return 0;
}
