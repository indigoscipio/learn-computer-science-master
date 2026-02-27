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

7.8
Supose that i and j are variablses type int
what is the type expression i / j + 'a'?

answer:
since we know i and j are both int
'a' is also integer therefore the final result of the expression
has a tpe of integer

evaluation wise

i/j is evaluated first -> integer
promotes 'a' to int (a is integer already but no need to promote)


*/


#include <stdio.h>

int main(void) {


    int n = 'a';

    printf("%d", 10 + 20 / n);

    return 0;
}
