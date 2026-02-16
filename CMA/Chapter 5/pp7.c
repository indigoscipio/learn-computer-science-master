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

Write a program that finds the largest and smallest of four integers entered by the user:
Enter four integers: 21 43 10 35
Largest: 43
Smallest: 10
Use as few if statements as possible. Hint: Four if statements are sufficient.


*/

#include <stdio.h>

int main(void) {
    int i1, i2, i3, i4, max1, max2, min1, min2, largest, smallest;

    printf("Enter four integers: \n");
    scanf("%d %d %d %d", &i1, &i2, &i3, &i4);

    if(i1 < i2){
        min1 = i1;
        max1 = i2;
    }else{
        min1 = i2;
        max1 = i1;
    }
    if (i3 < i4){
        min2 = i3;
        max2 = i4;
    }else{
        min2=i4;
        max2=i3;
    }
    if(max1 < max2){
        largest = max2;
    }else {largest = max1};
    if(min1 < min2){
        smallest = min1;
    }else {smallest = min2};

    printf("Smallest number is: %d \n",smallest);
    printf("Largest number is: %d \n",largest);

    return 0;
}
