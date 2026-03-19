
#include <stdio.h>
#include <stdbool.h>

/*
Expression vs statement
why c needs return value?
- in racket everything evals to value
- c needs to differentiate between expr and statement



// basic structure of a function
// difference between racket is that it seems we need to specify the type
// onthe function name and its argument
// you can also either have return value or not
double average(double a, double b){
    return (a + b) / 2;
}

printf("%f", average(1.0,5.0));
return 0;

// by default functions default to int type
// function prototypes = declaration whre you declare first, then call it in main/underneath it later

// params = template
// arg = value

// a prototype is likea early function definiton
// liek afunction but just a header
// since it needs to know how much space to reserve

// Compound literas
// used to make anontmous object
// a mix of type cast + initializer


*/

double average(double a, double b){
    return (a + b) / 2;
}

void print_count(int n){
    printf("T minus %d and counting...\n", n);
}

void print_pun(){
    printf("To C or not to C, That is the question.");
}

bool is_prime(int n){
    int divisor;
    if (n <=1){
        return false;
    }
    for(divisor=2;divisor*divisor<=n;divisor++){
        if(n % divisor == 0){
            return false;
        }
    }
    return true;
}

int main(void){

    /*
    //AVERAGE.C
    double x,y,z;
    printf("Enter three numbers: ");
    scanf("%1f%1f%1f", &x, &y, &z);
    printf("Average of %g and %g: %g\n", x,y,average(x,y));
    printf("Average of %g and %g: %g\n", y,z,average(y,z));
    printf("Average of %g and %g: %g\n", x,z,average(x,z));


    //PRINT COUNTDOWN
    int i;
    for(i=10; i>0; i--){
        print_count(i);
    }
    */

    /*
    //PRIMARLITY
    int n;
    printf("Enter a number: ");
    scanf("%d", &n);
    if(is_prime(n)){
        printf("Prime");
    }else{printf("Not prime");}
    */

    /*
    int fact(int n){
        if(n <= 1){
            return 1;
        }else{
            return n * fact(n - 1);
        }
    }
    printf("%d", fact(3));
    */

    int arr[] = {12,3,6,18,7,15,10};



    return 0;
}


