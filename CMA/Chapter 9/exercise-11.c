
#include <stdio.h>
#include <stdbool.h>


/*
Exercise 11
Write the following function:
float compute_GPA(char grades[] , int n) ;

The grades array will contain letter grades (A. B. C. D. or F. either upper-case or lower
case): n is the length of the array. The function should return the average of the grades
( assume that A = 4. B =3. C=2.B= 1.and F=0)



*/

#include <ctype.h>
#define N 5


float compute_GPA(char grades[],int n){
    int total=0;
    for(int i=0;i<n;i++){
        switch(grades[i]){
            case 'A':
            case 'a':
                total+=4;
                break;
            case 'B':
            case 'b':
                total+=3;
                break;
            case 'C':
            case 'c':
                total+=2;
                break;
            case 'D':
            case 'd':
                total+=1;
                break;
            default:
                total+=0;
                break;
        }
    }
    return (float)total/n;
}

int main(void){

    char grades[N] ={'A','B','C','D','A'};
int size = sizeof(grades) / sizeof(grades[0]);
    printf("The GPA is: %f\n", compute_GPA(grades, N));


    return 0;
}
