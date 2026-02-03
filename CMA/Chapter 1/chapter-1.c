#include <stdio.h>
/*this is the directive*/

#define FREEZING_PT 32.0f
#define SCALE_FACTOR (5.0f / 9.0f)

int main(void){
    float fahrenheit, celcius;


    printf("enter your fahrenheit: \n");
    scanf("%f", &fahrenheit);

    celcius = ((fahrenheit - FREEZING_PT) * SCALE_FACTOR);

    printf("celcius temperature is: %.1f", celcius);


    return 0;
}
