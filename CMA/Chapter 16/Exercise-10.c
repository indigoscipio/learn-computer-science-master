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
Exercise 10
The following structures are designed to store information about objects on a graphics
screen:

struct point { int x, y;};
struct rectangle {struct point upper_left, lower_right;};

A point structure stores the A and y coordinates of a point on the screen. A rectangle
structure stores the coordinates of the upper left and lower right corners of a rectangle. Write
functions that perform the following operations on a rectangle structure r passed as an
argument:

(a) Compute the area of r.
(b) Compute the center of r. returning it as a point value. If either the x or v coordinate of
the center isn't an integer, store its truncated value in the point structure.
(c) Move r by x units in the v direction and y units in the v direction, returning the modi
fied version of r. ( x and y are additional arguments to the function.)
(d) Determine whether a point p lies within r. returning true or false, (p is an addi
tional argument of type struct point.)


answer:

*/

struct point {int x,y};
struct rectangle {struct point upper_left, lower_right;};

int abs(int n){
    return n < 0 ? -n : n;
}

//PART A - compute area of r
// example: upper_left: 0,0 - lower_right: 5,3
// width = 5-0 - height = 3=0
int compute_area(struct rectangle r){
    // just multiply iths length and width
    // width is the absolute distance between upleft and lowright for each axis

    return abs(r.upper_left.x - r.lower_right.x) * abs(r.upper_left.y - r.lower_right.y);
}

//PART B
struct point compute_center(struct rectangle r){
    return (struct point) {.x = (r.upper_left.x + r.lower_right.x) / 2,
                           .y = (r.upper_left.y + r.lower_right.y) / 2};
}

//PART C
// given a rectangle and points x and y, returns a modiefied moved rectangle
struct rectangle move(struct rectangle r, int x, int y){

    struct rectangle new_r;
    new_r = r;
    new_r.upper_left.x += x;
    new_r.lower_right.x += x;
    new_r.upper_left.y += y;
    new_r.lower_right.y += y;

    return new_r;
}

//PART D
// determine if a point p lies within r, returns true or false
bool is_within_r(struct rectangle r, struct point p){
    // p is within r if
    // p is location somewhere within  r's upper left point and lower right point
    // first check if its between upper_left.x to lower_right.x
    // and check if its between upper_left.y to lower_right.y

    return (p.x >= r.upper_left.x && p.x <= r.lower_right.x) &&
            (p.y >= r.upper_left.y && p.y <= r.lower_right.y);
}


int main(void){

    printf("%d", abs(-8));

    return 0;
}
