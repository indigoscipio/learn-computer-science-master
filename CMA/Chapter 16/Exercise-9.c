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
Exercise 9

Write the following functions. (The color structure is defined in Exercise 8.)

a. struct color makecolor( int red, int green, int blue) ;
Returns a colorstructure containing the specified red. green ,and blue values. If any argu
ment is less than zero, the corresponding member of the structure will contain zero instead.
If any argument is greater than 255. the corresponding member of the structure will contain
255.

b.  int getRed( struct color c) ;
returns the value of c's red member.

c.  bool equalcolor( struct color colorl, struct color color2) ;
Returns true if the corresponding members of colorl and color2 are equal.

d. struct color brighter(struct color c) ;
Returns a color structure that represents a brighter version of the color c. The structure is
identical to c.except that each member has been divided by 0.7 (with the result truncated to
an integer). However, there are three special cases: ( I ) If all members of c are zero, the
function returns a color whose members all have the value 3. ( 2) If any member of c is
greater than 0 but less than 3. ii is replaced by 3 before the division by 0.7. (3) If dividing by
0.7 causes a member toexceed 255. it is reduced to 255

c. struct color darker(struct color c) ;
Returns a color structure that represents a darker version of the color c. The structure is
identical to c.except that each member has been multiplied by 0.7 (with the result truncated
to an integer).

answer:
*/

struct color{
    int red;
    int green;
    int blue;
};

// given an integer, if its < 0, reutrn 0
//if its less than zero, make it stay at zero
// if its greater than 255, cap it at 255
int clamp(int n){
    return n > 255 ? 255 : n < 0 ? 0 : n;
}

int clamp3(int n){
    return n > 0 && n < 3 ? 3 : n;
}

// PART A
struct color make_color(int red, int green, int blue){

    return (struct color) {clamp(red),clamp(green),clamp(blue)};
}

// PART B, basically make a simple selector
int getRed(struct color c){
    return c.red;
}

// PART C, basically a struct equailty check
bool equal_color(struct color c1, struct color c2){
    return (c1.red == c2.red && c1.green == c2.green && c1.blue == c2.blue);
}

// PART D
struct color color_brighter(struct color c){

    if(c.red == 0 && c.green == 0 && c.blue == 0){
        return (struct color) {3,3,3};
    }

    return (struct color) {clamp(clamp3(c.red)/0.7),
                           clamp(clamp3(c.green)/0.7),
                           clamp(clamp3(c.blue)/0.7)};
}

// PART E
struct color color_darker(struct color c){
    return;
}


int main(void){

    printf("%d", clamp(-1));

    return 0;
}
