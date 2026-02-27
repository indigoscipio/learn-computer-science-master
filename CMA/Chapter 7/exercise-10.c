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

7.10

Suppose that i isa variable of type int.
j is a variable of type long,
and k is a variable of type unsigned int.

What is the type of the expression i + (int) j * k?


answer:
we cast (int) j -> we demote the long j to int to j is int
next do j * k -> int * unsigned int - by default int is signed so we multiply signed * unsigned
which will result in unsigned integer

next add i (int) + result of j * k (unsigned)
therefore the type result is unsigned integer.



*/


#include <stdio.h>

int main(void) {


    int n = 'a';

    printf("%d", 10 + 20 / n);

    return 0;
}
