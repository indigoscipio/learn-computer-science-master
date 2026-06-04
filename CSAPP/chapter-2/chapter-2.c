#include stdio.h

void show_short(short int n){
    printf("%x", &n);
}

void show_long(long int n){
    0
}

void show_double(double d){
        0
}

int main(void){
    short int s = 32;
    long int l = 12345678987654321;
    double d = 1.23e20;

    show_short(s);
    show_long(n);
    show_double(d);

    return 0;
}
