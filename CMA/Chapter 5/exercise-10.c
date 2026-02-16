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

What output does die following program fragment produce?
(Assume that i is an integer variable.)

i = 1;
switch (i % 3) {
case 0: printf("zero");
case 1: printf("one");
case 2: printf("two");
}

answer:
first eval 1 % 3 which is 1 so the switch is run and check first case

case 0 is skipped
starts at case 1 -> prints one, since there is no break it falls through 2
case 2 -> pirnts two

to it should pritn someting like "one two"

*/

int main(void){
    int i,j;

    i = 1; j = 2;
    (i < j) ? -1 : (i > j) ? 1 : 0

    return 0;
}
