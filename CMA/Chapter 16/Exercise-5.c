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
Exercise 5
Write the following functions, assuming that the date structure contains three members:
month, day. and year (all of type int)

a. int day_of_year(struct date d);
Returns the day of the year (an integer between I and 366) that corresponds to the date d.


b. int compare_dates(struct date dl, struct date d2);
returns -1 if d1 is an earlier date than d2. +1 if d1 is a later date than d2.
0 if d1 and d2 are the same.

answer:

*/

// PART A
struct date {int month; int day; int year;};
struct date d1, d2, d3;

int day_of_year(struct date d){
    int arr[12] = {31,28,31,30,31,30,31,31,30,31,30,31}
    int result = 0, target_month = d.month, taget_day = d.day;

   //loop through the target month
   for(int i=0; i<d.month-1;i++){
        result+=arr[i]
   }
    return result + d.day;
}

int compare_dates(struct date d1, struct date d2){
    // check year
        //if year is equal, chech for month
            //if month is equal, check for day

    if(d1.year < d2.year){
        //d1 is earlier
        return -1;
    }else if(d1.year > d2.year){
        //d2 is earlier
        return 1;
    }else{
        //equal, check for month
        if(d1.month < d2.month){
            //d1 is early
            return -1;
        }else if(d1.month > d2.month){
            //d2 is early
            return 1;
        }else{
            //month are equal, check for day.
            if(d1.day < d2.day){
                // d1 is early
                return -1;
            }else if(d1.day > d2.day){
                //d2 is early
                return 1;
            }else{
                // they are both the same date
                return 0;
            }
        }
    }
}


int main(void){
    return 0;
}
