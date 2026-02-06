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
    int item_number,m,d,y;
    float unit_price;

    printf("Please enter your item numer: \n" );
    scanf("%d",&item_number);

    printf("Please enter your unit price: \n" );
    scanf("%f",&unit_price);

    printf("Please enter your purchase date (mm/dd/yyyy): \n" );
    scanf("%d/%d/%d",&m,&d,&y);

    printf("Item\tUnit\t\tPurchase\n",y,m,d);
    printf("\tPrice\t\tDate\n");
    printf("%d\t$%7.2f\t%02d/%02d/%04d\n",item_number,unit_price,m,d,y);


    return 0;
}
