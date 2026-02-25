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

Casting
3.14 -> cast into int -> becomes 3
when int * int is computed, value will also be int

*/

#include <stdio.h>

int main(void) {
    char ch;


    ch = getchar();
    printf("%c", ch);

    return 0;
}
