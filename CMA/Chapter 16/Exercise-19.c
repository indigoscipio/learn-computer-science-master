// main.c
#include <stdio.h>
#include <stdbool.h>

/*
STRUCTURE
like (define-struct name (x y z)) in racket.

DESIGNATED INITIALIZER
.something{property = x, property1 = y};
+ it's order independence, doesn't care about order
+ smart default, if the property is not defined it will be ste to default (0)
+ unitialized are set o 0

STRUCT OEPRATORS
= -> assign (shallow copy)
Yes you can copy structs but not array why?
coz struct has a 'fixed' size

STRUCT VARIABLE VS STRUCT TAG
the recipe
struct part {...} -> don't build anything yet
struct part part1 -> ok build it now/build on the 'go'

COMPOUND LITERAL
print_part((struct part) {528, "Disk drive", 10})
- its temporary, "anonymous" and for one-off tasks.
- can also include designators
*/


/*
Exercise 19
Declare a structure with the following members whose tag is pinball machine:
name-a string of up to 40characters
year-an integer (representing the year of manufacture)
type-an enumeration with the values EM (electromechanical ) and SS (solid state)
players-an integer (representing the maximum number of players)

answer:
*/

struct pinball_machine{
    char name[41];
    int year;
    enum {EM, SS} type;
    int players;
};


int main(void){

    printf("%d", abs(-8));

    return 0;
}
