#include <stdio.h>

/*
PRECEDENCE LEVEL
1. Postfix/Unary: ++, --, !, +, -
2. Mult: *, /, %
3. Add: +, -
4. Relational: >, <, <=, >= (left associative)
5. Equality: ==, !=
6. Logical AND: &&
7. Logical OR: ||
8. Assignment: =, *=, +=, ==, !=, etc

8. The following table shows the daily flights from one city to another:
Departure time
8:00 a.m.
Arrival time
10:16 a.m.
9:43 a.m.
11:19 a.m.
12:47 p.m.
11:52 a.m.
1:31 p.m.
3:00 p.m.
Programming Projects
2:00 p.m.
3:45 p.m .
7:00 p.m.
9:45 p.m.
4:08 p.m.
5:55 p.m.
9:20 p.m .
97
11 :58 p.m.
Write a program that asks user toentera time (expressed in hoursand minutes, using the 24
hour clock). The program then displays the departure and arrival times for the fiight whose
departure time is closest to that entered by the user:
Enter a 24-hour time: 13:15
Closest departure time is 12:47 p.m., arriving at 3:00 p.m.
Hint: Convert the input into a time expressed in minutes since midnight ,
and compare it to
the departure times, also expressed in minutes since midnight. For example. 13:15 is 13 x
60 + 15 = 795 minutes since midnight ,
which is closer to 12:47 p.m. (767 minutes since
midnight) than to any of the other departure times.
*/

#include <stdio.h>

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

    return 0;
}
