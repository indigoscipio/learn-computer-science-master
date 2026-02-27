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

7.11
Suppose that i is a variable of type int.
f is a variable of type float,
 d is a variable of type double.
 What is the type of the expression i * f / d?


answer:
first do i * f -> int * float = float, int is promoted to float
then do result of i * f / d -> float / double -> we promote float to double since it has higher
level/precision
therfore the result type is double


*/


#include <stdio.h>

int main(void) {


    int n = 'a';

    printf("%d", 10 + 20 / n);

    return 0;
}
