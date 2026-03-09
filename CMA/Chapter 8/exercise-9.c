#include <stdio.h>

/*
Exercise 9
Using the array of
Exercise 8. write a program fragment that computes the average tempera
ture for a month (averaged over alldays of the month and all hours of the day).

*/


#include <stdio.h>
#include <stdbool.h>

#define D 30
#define H 24

int main(void) {
    float temp_readings[D][H] = {0}, total_sum =0, avg_monthly_temp;

    // lets assume the temp readings area already provide/initialized
    // keep it simple
    //outer day loop
    for(i=0;i<D, i++){
        // inner hour loop
        for(j=0;j<H,j++){
            total_sum+=temp_readings[i][j];
        }
    }
    avg_monthly_temp = total_sum/D/H;

    return 0;
}
