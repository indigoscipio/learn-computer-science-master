/*
CHAPTER 11 : POITNER

a special piece of paper that has a room number on it
POINTER HOLDS AN ADDRESS

WHY POINTER?
- efficiency
- shared resource/access

&: addres operator
where is it??
int i -> value is here
&i -> get the address/room number of i

*: indirection operator (dereference operator)
go there!! aka the magical peeking portal
Get the value of xx
follow the address writeen here

RULE OF THIMB: INITIALIZE BEFORE INDIRECTION
- declare (int *p)
- initialize (p = &i);
- access (*p)

j=*&i is equal to j = i;

*q = *p -> - is right associative

POINTER AS RETURN VALUE
int *max(int *a, int *b)

here the params *a and *b are't acting as dereference
but its part of type declaration

so when we call a or b it returns a pointer
when we do *a or *b inside the function it dereference and returns teh value

ROLE OF ASTERISK
in declaration: -> int *a -> defines variable type. a is a pointer.
in expr -> *a inside a body -> acts as a dereference -> peek inside and gets the value


& and * are inverses
& goes from variable -> address
* goes from address -> variable

----------------------------------------------------

PP2
Modify ProgrammingProject S fromChapter 5 so that it includes the following function
void find closestflight(int desired_time, int *departure_time, int *arrival_time);


This function will find the flight whose departure time is closest to desired
_time
(expressed in minutes since midnight). It will store the departure and arrival times of this
llight (also expressed in minutes since midnight) in the variables pointed to by
departure
_time andarrival
_time.respeetively.

answer:
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

#define N 8

void find_closest_time(int desired_time, int *departure_time, int *arrival_time){
    int i;
    int dt_arr[N] = {480,583,679,767,840,945,1140,1305};
    int at_arr[N] = {616,712,811,900,968,1075,1280,1438};

    //comparison loop
    for(i=0; i<N-1; i++){
        if( desired_time <= (dt_arr[i]+dt_arr[i+1])/2 ){
            *departure_time = dt_arr[i];
            *arrival_time = at_arr[i];
            printf("Closest departure time is: %d", dt_arr[i]);
            break;
        }
    }

    if(i == N-1){
        *departure_time=dt_arr[N-1];
        *arrival_time=at_arr[N-1];
    }
}

int main(void){
    int h24, m24, desired_time, departure_time, arrival_time;

    printf("Enter a 24 hour time: \n");
    scanf("%02d:%02d", &h24, &m24);

    // convert to minutee
    desired_time=h24 * 60 + m24;

    find_closest_time(desired_time, &departure_time, &arrival_time);
}

/*
FROM PP8 CHAPTER 55
int main(void) {
    int h24, m24, dt1, dt2, dt3, dt4, dt5, dt6, dt7, dt8, minute_since_midnight, midpoint, closest;

    dt1 = 8 * 60;
    dt2 = 9 * 60 + 43;
    dt3 = 11 * 60 + 19;
    dt4 = 12 * 60 + 47;
    dt5 = 14 * 60;
    dt6 =  15 * 60 + 45;
    dt7 = 19 * 60;
    dt8 = 21 * 60 + 45;

    printf("Enter a 24 hour time: \n");
    scanf("%02d:%02d", &h24, &m24);

    minutes_since_midnight = (h24 * 60) + m24;

    if (minutes_since_midnight <= (dt1 + dt2) / 2) {
        printf("Closest departure time is 8:00 a.m., arriving at 10:16 a.m.\n");
    } else if (minutes_since_midnight <= (dt2 + dt3) / 2) {
        printf("Closest departure time is 9:43 a.m., arriving at 11:52 a.m.\n");
    } else if (minutes_since_midnight <= (dt3 + dt4) / 2) {
        printf("Closest departure time is 11:19 a.m., arriving at 1:31 p.m.\n");
    } else if (minutes_since_midnight <= (dt4 + dt5) / 2) {
        printf("Closest departure time is 12:47 p.m., arriving at 3:00 p.m.\n");
    } else if (minutes_since_midnight <= (dt5 + dt6) / 2) {
        printf("Closest departure time is 2:00 p.m., arriving at 4:08 p.m.\n");
    } else if (minutes_since_midnight <= (dt6 + dt7) / 2) {
        printf("Closest departure time is 3:45 p.m., arriving at 5:55 p.m.\n");
    } else if (minutes_since_midnight <= (dt7 + dt8) / 2) {
        printf("Closest departure time is 7:00 p.m., arriving at 9:20 p.m.\n");
    } else {
        printf("Closest departure time is 9:45 p.m., arriving at 11:58 p.m.\n");
    }


    printf("Closest departure time is: XXX, arriving at XXX");

    return 0;
}
*/
