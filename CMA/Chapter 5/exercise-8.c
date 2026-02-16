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

Exercise 8
The following if statement is unnecessarily complicated.
Simplify it as much as possible.

(Hint: The entire statement can be replaced by a single assignment.)

if (age >= 13)
    if (age <= 19)
        teenager = true;
    else
        teenager = false;
else if (age < 13)
    teenager = false;

answer:
ok let me try to understand this
first the outcer checks if age is either >=13 or < 13
if it goes first it does another check again

so teenager has a range between 13 - 19 and all number beside this is not,
therefore we can simplify to something like this

(age >= 13 && age <= 19) ? teenager = true : teenager = false

or if we do if statement something like this
if (age >= 13 && age <= 19){
    teenager = true;
}else{
    teenager = false;
}

or even simpler
teenager = (i >= 13) && (i <= 19)

*/

int main(void){
    int i,j;

    i = 1; j = 2;
    (i < j) ? -1 : (i > j) ? 1 : 0

    return 0;
}
