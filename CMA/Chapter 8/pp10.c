#include <stdio.h>

/*
PP10
Modify Programming Project 8 from Chapter 5 so that the departure times
are stored in an array and the arrival times are stored in a second array.

( The times are integers, representing the number of minutes since midnight.)
The program will use a loop tosearch the array of departure times for the one
closest to the time entered by the user.

*/


#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(void) {
    int h24, m24, dt1, dt2, dt3, dt4, dt5, dt6, dt7, dt8, minutes_since_midnight, midpoint, closest;
    int at1,at2,at3,at4,at5,at6,at7;
    bool found = false;

    dt1 = 8 * 60;
    dt2 = 9 * 60 + 43;
    dt3 = 11 * 60 + 19;
    dt4 = 12 * 60 + 47;
    dt5 = 14 * 60;
    dt6 =  15 * 60 + 45;
    dt7 = 19 * 60;
    dt8 = 21 * 60 + 45;

    at1 = 10 * 60 + 16;
    at2 = 11 * 60 + 52;
    at3 = 1 * 60 + 31;
    at4 = 3 * 60;
    at5 = 4 * 60 + 8;
    at6 = 5 * 60 + 55;
    at7 = 9 * 60 + 20;
    at8 = 11 * 60 + 58;

    int departure_times_arr[8] = {dt1,dt2,dt3,dt4,dt5,dt6,dt7,dt8};
    int arrival_times_arr[8] = {at1,at2,at3,at4,at5,at6,at7,at8}

    printf("Enter a 24 hour time: \n");
    scanf("%02d:%02d", &h24, &m24);

    minutes_since_midnight = (h24 * 60) + m24;

    int i;
    for(i=0;i<7;i++){
        midpoint = (departure_times_arr[i] + departure_times_arr[i+1]) / 2;

        if(minutes_since_midnight <= midpoint){
            // first one
            int h = arrival_times_arr[i] / 60;
            int m = arrival_times_arr[i] % 60;
            const char *period = (h >= 12) ? "p.m." : "a.m.";

            if (h > 12) h -= 12;
            else if (h == 0) h = 12;

            printf("Closest departure time is %d:%02d %s, arriving at %d:%02d %s\n",
           /* add departure variables here */,
           h, m, period);

            found = true;
            break;
        }
    }

    if(!=found) printf("Arrival time is at: %02d:%02d", (arrival_times_arr[7] / 60), (arrival_times_arr[7] % 60) );

    return 0;
}
