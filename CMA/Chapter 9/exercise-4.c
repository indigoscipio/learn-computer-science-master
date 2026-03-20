
#include <stdio.h>
#include <stdbool.h>

/*
Exercise 4
Writeafunction day_ of year(month, day, year) that returnsthe day of the year
(an integer between l and 366)specified by the three arguments
*/


int day_of_year(int month, int day, int year){

    int days_in_month[] = {31,28,31,30,31,30,31,31,30,31,30,31};
    int total_days = 0 + day;

    for(int i=0; i<month-1; i++){
        // add up the days
        total_days+=days_in_month[i];
    }

    //leap year
    if(month > 2 && ((year % 4 == 0 && year % 100 != 0)  || (year % 400 == 0))){
        total_days++;
    }

    return total_days;

}

int main(void){
    int d,m,y;

    // Jan = 1, Dec = 12
    printf("Enter day, month, and year: \n");
    scanf("%d %d %d", &d, &m, &y);

    printf("Total days is: %d", day_of_year(d,m,y));


    return 0;
}
