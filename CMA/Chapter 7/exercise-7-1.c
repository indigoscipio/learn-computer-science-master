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

Exercise 7.1
givee decimal value of each of the following integer constant
a. 077
b. 0x77
c. 0xabc

answer:
a. this is octal
7 . 8^1 + 7 . 8^0 =  56+7 = 63

b. this is hex
7 . 16^1 + 7 . 16^0 = 112+7 = 119

c. also hex
10 . 16^2 + 11 . 16^1 + 12 . 16^0 = 2560+176+12 = 2748



*/

#include <stdio.h>

int main(void) {

    printf("%f", sizeof(int));

    return 0;
}
