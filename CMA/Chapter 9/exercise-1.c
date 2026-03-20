
#include <stdio.h>
#include <stdbool.h>

/*
Exercise 1
The following function ,which computes the area of a triangle, contains two errors. Locate
the errors and show how totlx them. ( Hint: There arc no errorsin the formula.)
double triangle_ area( double base, height)
double product;
{
product = base * height;
return product / 2 ;

answer:
1. the parameter height's type is not specified
2. the triangle_area is defined incorrectly
3. double product should be defined in the body

it shoud be something like

double triangle_area(double base, double height){
    double product;
    product = base * height;
    return product / 2;
}

}


*/

int main(void){

    double triangle_area(double base,double height)
    double product;
    {
        product = base * height;
        return product / 2;
    }

    return 0;
}


