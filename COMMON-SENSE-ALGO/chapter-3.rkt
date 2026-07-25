#lang racket

; BIG O
; how does the number of steps change as dataset gets bigger?
; O(N) -> if there are N element in the array, how many step will it take?


; EXERCISES

#|
1. 
Use Big O notation to describe the time complexity of the following function
that determines whether a given year is a leap year:

def is_leap_year(year):
if year % 100 == 0:
if year % 400 == 0:
return False
else:
return True
return year % 4 == 0

answer:
ok i dont know al ot about python 
but the input year is an integer
so is_leap_yaer is integer -> boolean

lets analyze

outer if -> modulo check
inner if -> module check

no iteration or loops
so im guessing its like constant/instant here?
assuming remainder/modulo takes constant time and if check also
so O(1)

______________________


2.Use Big O notation to describe the time complexity of the following function
that sums up all the numbers from a given array:

def array_sum(array):
sum = 0
for number in array:
sum += number
return sum

answer:

so we know array_sum :: list-of-number -> number
it has a for loop which checks each item in the list
and sums it to the tally

since it has to sum each number in the list one by one, total
running time is O(n)

______________________

3.  The following function is based on the age-old analogy used to describe
the power of compounding interest:

Imagine you have a chessboard, and put a single grain of rice on one
square. On the second square, you put two grains of rice, since that is
double the amount of rice on the previous square. On the third square,

you put four grains. On the fourth square, you put eight grains, and on
the fifth square, you put sixteen grains, and so on.
The following function calculates which square you’ll need to place a
certain number of rice grains. For example, for sixteen grains, the function
will return 5, since you will place the sixteen grains on the fifth square.

Use Big O notation to describe the time complexity of this function, which
is below:
def chessboard_space(number_of_grains):
chessboard_spaces = 1
placed_grains = 1
while placed_grains < number_of_grains:
placed_grains *= 2
chessboard_spaces += 1
return chessboard_spaces

answer:
ok so in the story thing its like
1 -> 1
2 -> 2
3 -> 4
4 -> 16
5 -> 32
basically doubles each count

but he  in the function described ittakes the final value
eg number of rains and reverses so we wanna find the 'chessboard place'

number -> number
not sure if palced_grains *= 2 is constant here?
lets do smalle example chessboard_space(32)

chessboard_spaces = 1
placed_grains = 1

1 < 32 -> true
double placed grains -> 2
increase chessboard space -> 2

2 < 32 -> true
double -> 4
increase -> 3

.. keep repeating until >= 32

so running time for the loop is
double the number + increment the chessboard space

since it halfs the search space by half
its log n + 1 => log n

______________________

4.
 The following function accepts an array of strings and returns a new array
that only contains the strings that start with the character "a". Use Big O
notation to describe the time complexity of the function:

def select_a_strings(array):
new_array = []
for string in array:
if string[0] == "a":
new_array.append(string)
return new_array

answer:
ok so the function takes string -> string

we have a for loop which checks each char in array since theres
no stopping condition

so running time for that depends on length of string in array/char length
regardless if a is the first cahr or not
assuming the string[0] == "a" comparison takes instant
and appending also takes constant

therefore the running time is just length of the string of the array
linear or O(n)

5.
The following function calculates the median from an ordered array.
Describe its time complexity in terms of Big O notation

def median(array):
if not array:
return None
middle = len(array) // 2
# If array has even amount of numbers:
if len(array) % 2 == 0:
return (array[middle- 1] + array[middle]) / 2.0
else: # If array has odd amount of numbers:
return array[middle]

answer:
ok so the function take array and returns a number
no for loops orrecursion

first if check -> array empty just return none

then middle -> find mid value which takes constant,
assuming length function is sintant

then the if
if even -> value reference, sum and division so this takes instant
if odd -> just reutrn the middle which is also instant

so its just O(1)?


______________________




|#