
#include <stdio.h>
#include <stdbool.h>

/*
Exercise 9
What will be the output of the followingprogram?


#include <stdio.h>

void swap (int a, int b);

int main(void)
{
int i = 1, j = 2;
swap(i, j );
printfC'i = %d, j = %d\n", i, j);
return 0;
}

void swap(int a, int b)
{
int temp = a;
a = b;
b = temp;
}

answer:
ok so let me try to analyze what swap and main does
lets start wit swap
it takes 2 ints and reutrns nothing so it performs a side effect
it holds the 1st arg into a temporary var
then it swaps with b with a,
and swaps b with the temp var and returns nothing or doesn't print anything

and in main we have defined 2 ints i and j
we perform the swap operation with i and j fed, which doesn't reutrn or mutate the i or j since its on different scope.
then afterwards we print
"i = 1, j = 2" so its literally printing the var we just defined on the top



*/
int main(void){
    double x;

    x = f(83.55,12.88);
    printf("%d", x);

    return 0;
}

/*
racket version
(cond []
      [])
*/

