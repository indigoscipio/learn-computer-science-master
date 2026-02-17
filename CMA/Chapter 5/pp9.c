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

PP9
Write a program that prompts the user to enter two dates and then indicates which date
comes earlier on the calendar:
Enter first date (mm/dd/yy): 3/6/08
Enter second date (mm/dd/yy): 5/17/07
5/17/07 is earlier than 3/6/08
*/

#include <stdio.h>

int main(void) {
    int m1, d1, y1, m2, d2, y2, date_num_1, date_num_2, earlier_date;

    printf("Enter first date (mm/dd/yy)\n");
    scanf("%02d/%02d/%02d", &m1, &d1, &y1);

    printf("Enter second date (mm/dd/yy)\n");
    scanf("%02d/%02d/%02d", &m2, &d2, &y2);

    /*
    if(y1 > y2){
        printf("%02d/%02d/%02d is earlier", m2,d2,y2);
    }else if(y1 < y2) {
        printf("%02d/%02d/%02d is earlier", m1,d1,y1);
    }else{
        if(m1>m2){
        printf("%02d/%02d/%02d is earlier", m2,d2,y2);
        }else if(m1<m2){
        printf("%%02d/%02d/%02d is earlier", m1,d1,y1);
        }
        else{
            if(d1>d2){
            printf("%02d/%02d/%02d is earlier", m2,d2,y2);
            }else if(d1<d2){
            printf("%02d/%02d/%02d is earlier", m1,d1,y1);
            }else{
            printf("they are both the same date");
            }
        }
    }
    */


    // method 2: sum of numbers
    date_num_1 = (y1 * 10000) + (m1 * 100) + d1;
    date_num_2 = (y2 * 10000) + (m2 * 100) + d2;

    if(date_num_1 < date_num_2){
        printf("%02d/%02d/%02d is earlier", m1,d1,y1);
    }
    else{
        printf("%02d/%02d/%02d is earlier", m2,d2,y2);
    }

    return 0;
}
