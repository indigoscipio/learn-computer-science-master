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

If c is a variable of type char
which one ofthe folowing statements is ilegal?
a. i += c; -i has type int
b. c = 2 * c - 1;
c. putchar(c);
d. printf(c);

answer:
a. this is legal because char is just an integer
b. also legal since everthing is int here
c. legal coz puchar expects char
d. this one is not legal because printf(c) expects a string and avar
it sholdve been printf("%c", x) where x is the char variable


*/

#include <stdio.h>

int main(void) {


    char a='a';

    printf("%c", a);

    return 0;
}
