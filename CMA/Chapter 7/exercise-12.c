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

7.12
Suppose that i is a variable of type int.
f is a variable of type float,
and d is a variable of type double.

Explain what conversions take place during the execution of the following statement:
d = i + f;

first  do the i + f
since we know its int + float -> promotes int to float therefore the result is float

next the assignment
d = float
since we know double has higher level/precision than float
the float will be cast as double.


*/


#include <stdio.h>

int main(void) {


    int n = 'a';

    printf("%d", 10 + 20 / n);

    return 0;
}
