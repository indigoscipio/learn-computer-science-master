// main.c
#include <stdio.h>


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
Exercise 6
Write the following function,
assuming that the time structure contains three members:
hours, minutes,and seconds (all of type int ).answer:

struct time split_time(long total_seconds);

total seconds is a time represented as the number of seconds since midnight. The
function returns a structure containing the equivalent time in hours (0-23) . minutes (0-59) .
and seconds (0-59) .

answer: lets keep it simple
*/

struct time {int hours; int minutes; int seconds;};

struct time split_time(long total_seconds){

    /*
    // split the hour
    // split the minute
    // split the remaining seconds
    int h=0,m=0,s=0;
    struct time t_result;

    h = total_seconds/3600;
    m = (total_seconds - (h*3600)) / 60;
    s = total_seconds - (h*3600) - (m*60);

    t_result.hours=h;
    t_result.minutes=m;
    t_result.seconds=s;

    return t_result;
    */


    int h=0,m=0,s=0;
    struct time t_result;

    h = total_seconds / 3600;
    m = (total_seconds - (h*3600)) / 60;
    s = total_seconds % 60;
    return (struct time) {h,m,s};

}


int main(void){

    return 0;
}
