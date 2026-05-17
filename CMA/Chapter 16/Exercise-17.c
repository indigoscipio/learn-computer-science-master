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
Exercise 17
suppose b and i are declared as follows:

enum {FALSE, TRUE} b;
int i;

Which of the following statements are legal? Which ones arc "safe"( always yield a mean
ingful result)?

(a) b = FALSE;
(b) b = i;
(C) b++;
(d) i = b;
(e) i = 2 * b + 1;

answer:
ok let me try this one
a. since b is an enum it has unintialized value
then we assign value to false so new value of b is now false
so its legal

b. here we assign i to b
and since we know i is a type of int
ithink its elgal but but i value is not initialized

c. here we increment the vale of b
since we know b is a enum it has initialized value and when we increase it
still elgal but junk value i think

d. meaningful since i can take any integer value

e. i can hold 1 or 3 so it s legal and valud

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
