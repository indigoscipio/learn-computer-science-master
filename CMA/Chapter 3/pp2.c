#include <stdio.h>
/*
Write a program that formats product information entered by the user. A session with the
program should look like this:
Enter item number: 583
Enter unit price: 13.5
Enter purchase date (mm/dd/yyyy): 10/24/2010
Item
583
Unit
Price
$ 13.50
Purchase
Date
10/24/2010
The item number and date should be left justified; the unit price should be right justified.
Allow dollar amounts up to$9999.99. Hint: Use tabs to line up the columns.


*/

int main(void){
    int m,d,y;

    printf("Please enter your date (mm/dd/yyyy): \n" );
    scanf("%d/%d/%d",&m,&d,&y);

    printf("You entered the date: %.4d%.2d%.2d",y,m,d);


    return 0;
}
