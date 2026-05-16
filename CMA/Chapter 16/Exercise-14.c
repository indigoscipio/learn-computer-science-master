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
Exercise 14
Let shapebe the structure tag declared in Exercise 13. Write functions that perform the
following operations on a shape structure s passed as an argument:

a. compute the area of s.
b. Move sby x units in the x direction and y units in the y direction, returning the modi
fied version of s. ( x and y are additional arguments to the function.)
c. Scale sby a factor of c(a doublevalue), returning the modified version of s.(c is an
additional argument to the function.)

*/
#define RECTANGLE 0
#define CIRCLE 1
#define PI 3.14

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

// PART A - compute area of s
double compute_area(struct shape s){
    if(s.shape_kind == RECTANGLE){
        return s.u.rectangle.height * s.u.rectangle.width;
    }else{
        return (s.u.circle.radius * s.u.circle.radius) * PI;
    }
}

// PART B
struct shape move(struct shape s, int x, int y){
    s.center.x+=x;
    s.center.y+=y;
    return s;
}

// PART C
struct shape scale(struct shape s, double c){
    if(s.shape_kind == RECTANGLE){
        s.u.rectangle.height*=c;
        s.u.rectangle.width*=c;
    }else{
        s.u.circle.radius*=c;
    }

    return s;
}

int main(void){

    printf("%d", abs(-8));

    return 0;
}
