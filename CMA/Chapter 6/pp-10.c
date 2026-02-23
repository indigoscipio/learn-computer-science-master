#include <stdio.h>

/*
LOOPS

while : checks cond before the body rund
do-while : checks cond after body runs
for : like while, but designed with how many times you wanna run it

for(xx) < here xx is called "controlling expression"

=============================================================
PP9

Programming Project 9 inChapter 5asked you to writea program that determines which of
twodates comes earlier on (he calendar.Generalize the program so that the user may enter
any number ofdates. The user will enter0/0/0 to indicate that no moredates willbe entered:

Enter a date (mm/dd/yy): 3/6/08
Enter a date (mm/dd/yy): 5/17/07
Enter a date (mm/dd/yy): 6/3/07
Enter a date (mm/dd/yy): 0/0/0
5/17/07 is the earliest date

*/

#include <stdio.h>

int main(void) {
    int m1, d1, y1, m2, d2, y2;
    int earliest_date, new_date;
    int earlier_m, earlier_d, earlier_y;

    printf("Enter a date (mm/dd/yy)\n");
    scanf("%02d/%02d/%02d", &m1, &d1, &y1);

    earliest_date = (y1 * 10000) + (m1 * 100) + d1;
    earlier_m = m1;
    earlier_y = y1;
    earlier_d = d1;

    for(;;){
        printf("Enter a date (mm/dd/yy)\n");
        scanf("%02d/%02d/%02d", &m2, &d2, &y2);

        if(m2==0 && d2==0 && y2 == 0){
            break;
        }

        new_date = (y2 * 10000) + (m2 * 100) + d2;

        if(new_date < earliest_date){
            earliest_date = new_date;
            earlier_m = m2;
            earlier_d = d2;
            earlier_y = y2;
        }
    }
    printf("%02d/%02d/%02d is earlier", earlier_m,earlier_y,earlier_d);

    return 0;
}
