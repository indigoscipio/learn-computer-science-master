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
Exercise 13

Suppose that s is the following structure (point is a structure tag declared in Exercise 10):

struct shape {
int shape_kind;
    struct point center;
    union {
        struct {
            int height, width;
        }rectangle;
        struct{
            int radius;
        }circle
    } u;
}s;

If the value of shape kind is RECTANGLE,
the height and width members store the
dimensions of a rectangle. If the value of shape kind is CIRCLE,the radius member
stores the radius of a circle. Indicate which of the following statements are legal, and show
how to repair the ones that aren’t:

(a) s.shapekind = RECTANGLE;
(b) s.center.x = 10;
(c) s.height = 25;
(d) s.u.rectangle.width = 8;
(e) s.u.circle = 5;
(f) s.u.radius = 5;

answer:
a. ok so we have s.shape_kind = RECTANGLE;
what is rectangle here? its an int right? assume RECTANGLE is already an int then its correct
b. this one is also legal since point has x and y and we can jsut extract both
c. this one idont think its legal since height is within rectangle union
assuming shape_kind is rectangle we can extract it with s.u.rectangle.height = 25;
d. this one is legal
e. incorrect, if we want to change radius we do s.u.circle.radius instead
because circle itself is a struct within union u
f. incorrect, should be s.u.circle.radius = 5


*/




int main(void){

    printf("%d", abs(-8));

    return 0;
}
