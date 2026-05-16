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
Exercise 15
a) Declare a tag foran enumeration whose values represent the seven days of the week.
b) Use typedef to define a name for the enumeration of part (a)

answer:

*/

enum days_of_the_week {Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday};

typedef enum {Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday} days_of_the_week;

#define RECTANGLE 0
#define CIRCLE 1
#define PI 3.14


int main(void){

    printf("%d", abs(-8));

    return 0;
}
