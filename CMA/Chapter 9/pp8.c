/*
PP8

Write a program that simulates the game of craps, which is played w ith two dice. On the
first roll, the player wins if the sum of the dice is 7 or 11. The player loses if the sum is 2. 3
or 12 .Any other roll is called the “point "and thegame continues.On eachsubsequent roll ,
the player winsif he or she rolls the point again .The player losesby rolling 7. Any other roll
is ignored and the game continues. At the end of each game, the program will ask the user
whether or not to play again. When the user entersa response otherthan yorY. the program
will display the number of wins and losses and then terminate

You rolled: 8
Your point is 8
You rolled: 3
You rolled: 10
You rolled: 8
You win!
Play again? y
You rolled: 6
Your point is 6
You rolled: 5
You rolled: 12
You rolled: 3
You rolled: 7
You lose!
Play again? y
You rolled: 11
You win!
Play again? n
Wins: 2 Losses: 1
Write your program as three functions: main. roll
_ dice. and play_game. Here are
the prototypes for the latter two functions:
int roll_dice(void);
bool play_game(void);
roll_ diceshould generate two random numbers,each between I and 6. and return their
sum. play game should play onecraps game (calling roll dice to determine the out
come of each dice roll):it will return trueif the player wins and falseif the player loses.
play_game is also responsible for displaying messages showing the resultsof the player 's
dice rolls ,
main will call play_game repeatedly,keeping track of the number of wins and
losses and displaying the “you win "and “you lose” messages. Hint: Use the rand function
to generate random numbers. See the deal.c program in Section 8.2 for an example of
how tocall randand the related srand function.


*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

//prototypes
bool play_game(void);
int roll_dice(void);

bool play_game(void){
    int point;
    //play one craps game
        //true if win, false if lose

    int rand_n = roll_dice();

    if(rand_n == 7 || rand_n == 11){
        printf("You rolled: %d\n", rand_n);
        printf("You win!");
        return true;
    }else if(rand_n == 2 || rand_n == 3 || rand_n == 12){
        printf("You rolled: %d\n", rand_n);
        printf("You lose!");
        return false;
    }
    else{
        //point phase
        printf("Your point is: %d\n", rand_n);

        while(true){
            int rand_n1 = roll_dice();
            printf("You rolled: %d\n", rand_n1);
            if(rand_n1 == rand_n){
                printf("You win!");
                return true;
            }
            if(rand_n1 == 7){
                printf("You lose!");
                return false;
            }
        }
    }
}

int roll_dice(void){
    //generate 2 random num, each between 1 and 6
    // and return their sum
    int d1 = (rand() % 6) + 1;
    int d2 = (rand() % 6) + 1;
    return d1 + d2;
}

int main(void) {
    srand(time(NULL));
    bool is_game_over = false;

    while(is_game_over == false){}
    /*
    do{
        play_game();
    }while(is_game_over==false);
    */
    // call play game repeatedly
    // keep track of wins and loses and display "you win" or "you lose"

    return 0;
}
