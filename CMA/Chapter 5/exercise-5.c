#include <stdio.h>

/*
PRECEDENCE LEVEL
1. Postfix/Unary: ++, --, !, +, -
2. Mult: *, /, %
3. Add: +, -
4. Relational: >, <, <=, >= (left associative)
5. Equality: ==, !=
6. Logical AND: &&
7. Logical OR: ||
8. Assignment: =, *=, +=, ==, !=, etc


Exercise 5
Is the following if statement legal?

if (n >= 1 <= 10)
printf("n is between 1 and 10\n");

If so. what does it do when n isequal to 0?
answer:

this is legal but incorrect because of missing && operator
if n = 0 instead of giving a range

it calculates n >=1 -> 0 >= 1 -> 0 which is false
then 0 <= 10 which is true/1 so it evalutes to true
and the printf is run iwth "1 is between 1 and 10"

*/

int main(void){
    int i,j;

    i = 1; j = 2;
    (i < j) ? -1 : (i > j) ? 1 : 0

    return 0;
}
