#include <stdio.h>

/*
PP7

Modify Programming Project 8 from Chapter 5 so that the user enters a lime using the
12hour clock. The input will have the form hours-.minutes followed by either A, P. AM, or PM
( either lower-case or upper-case). White space is allowed (but not required) between the
numerical time and the AM/PM indicator. Examples of valid input:

1:15P
1:15PM
1:15p
1:15pm
1:15 P
1:15 PM
1:15 p
1:15 pm

You may assume that the input has one of these forms; there is no need to test for errors.
*/


#include <stdio.h>
int main(void) {

    int h24, m24, minutes_since_midnight;
    int dt1, dt2, dt3, dt4, dt5, dt6, dt7, dt8;
    char ch;

    // Departure times in minutes since midnight
    dt1 = 8 * 60;           // 8:00 a.m.
    dt2 = 9 * 60 + 43;      // 9:43 a.m.
    dt3 = 11 * 60 + 52;     // 11:52 a.m.
    dt4 = 12 * 60 + 47;     // 12:47 p.m.
    dt5 = 14 * 60;          // 2:00 p.m.
    dt6 = 15 * 60 + 45;     // 3:45 p.m.
    dt7 = 19 * 60;          // 7:00 p.m.
    dt8 = 21 * 60 + 45;     // 9:45 p.m.

    printf("Enter a 24-hour time: ");
    scanf("%d:%d %ch", &h24, &m24, &ch);

    //validate ch here
    //for each digit in minute, check if it contain valid meridian (p,P,a,A,AM,am,PM,pm)
    //if not its not valid
    if(m24){
        ..
    }

    minutes_since_midnight = (h24 * 60) + m24;

    // Find closest departure by comparing to midpoints
    if (minutes_since_midnight < (dt1 + dt2) / 2) {
        printf("Closest departure time is 8:00 a.m., arriving at 10:16 a.m.\n");
    } else if (minutes_since_midnight < (dt2 + dt3) / 2) {
        printf("Closest departure time is 9:43 a.m., arriving at 11:52 a.m.\n");
    } else if (minutes_since_midnight < (dt3 + dt4) / 2) {
        printf("Closest departure time is 11:52 a.m., arriving at 1:31 p.m.\n");
    } else if (minutes_since_midnight < (dt4 + dt5) / 2) {
        printf("Closest departure time is 12:47 p.m., arriving at 3:00 p.m.\n");
    } else if (minutes_since_midnight < (dt5 + dt6) / 2) {
        printf("Closest departure time is 2:00 p.m., arriving at 4:08 p.m.\n");
    } else if (minutes_since_midnight < (dt6 + dt7) / 2) {
        printf("Closest departure time is 3:45 p.m., arriving at 7:00 p.m.\n");
    } else if (minutes_since_midnight < (dt7 + dt8) / 2) {
        printf("Closest departure time is 7:00 p.m., arriving at 9:20 p.m.\n");
    } else {
        printf("Closest departure time is 9:45 p.m., arriving at 11:58 p.m.\n");
    }

    return 0;
}
