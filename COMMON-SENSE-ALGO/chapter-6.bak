#lang racket

; CHAPTER 5

; SELSORT
; each pass -> check lowest
; swap value with beginning value
; 2613 -> 1623
; repeat until the end

; example: 42713
; init lowest = 4
; 1st -> scan whole. lowest = 1 -> swap 1 with 4 -> 12743
; next skip 1 -> start with 2nd item (2) -> init lowest value = 2
; 2nd -> scan whole. lowest = 2 -> 2 = 2, no more lowest -> correct position ->
; 12743
; next skip 2 -> start with 3rd item (7) -> init lowest value = 7
; 3rd -> scan whole. lowest = 3 -> swap 3 with 7 -> 12347

(define (remove-from-list-once target xs)
  (cond [(null? xs) '()]
        [(equal? target (car xs)) (cdr xs) ]
        [else (cons (car xs) (remove-from-list-once target (cdr xs)))]
        )
  )



(define (extract-min xs)
  ; number list-of-number -> listof number listof-number 
  (define (helper curr-xs champ rejects)
    (cond [(null? curr-xs) (list champ rejects)]
          [(< (car curr-xs) champ) ;new champ found
           (helper (cdr curr-xs) (car curr-xs) (cons champ rejects) )]
          [else (helper (cdr curr-xs) champ (cons (car curr-xs) rejects))]
          ; keep champ
          )
    )
  (helper (cdr xs) (car xs) '())
  )
(extract-min '(4 2 7 1 3))

; SELECTION SORT
; functional approach/listbased
(define (selection-sort lst)

  #|
  ; list-of-number -> cons number listof-number
  ; remove min from that list, returnin min and rest of hte list
  (define (find-min-and-remove-from-rest xs)
    (let ((min-val (apply min xs)))
      (list min-val (remove-from-list-once min-val xs))
      )
    )
 |#
  
  ; main loop: build list as you recurse
  (define (loop xs)
    (cond [(null? xs) '()]
          [else (let* ((res (extract-min xs))
                       (curr-min (car res))
                       (rest (cadr res))
                       )
                  (cons curr-min (loop rest))
                  )]
          )
    )
  (loop lst)
 
  
  )
(selection-sort '(4 2 7 1 3))

; SELECTION SORT
; imperative approach/vector
; outer loop -> boundary between sorted and unsorted
; inner loop -> scans remaining unsorted
(define (selection-sort-v2 vect)
  (let ((n (- (vector-length vect) 1)))
    ; number number -> vector
    (define (swap i j v)
      (let ((temp-i (vector-ref v i)))
        (begin (vector-set! v i (vector-ref v j))
               (vector-set! v j temp-i)
               v)
        )
      )

    ; vector -> number
    (define (find-min-index v curr-i min-so-far-i)
      (cond [(> curr-i n) min-so-far-i]
            [else (let ((min-so-far-val (vector-ref v min-so-far-i))
                        (curr-val (vector-ref v curr-i)))
                    (if (< curr-val min-so-far-val)
                        (find-min-index v (+ curr-i 1) curr-i) ; new champ
                        (find-min-index v (+ curr-i 1) min-so-far-i); keep finding
                        )
                    )]
            )
      )

    ; main function
    ; find min index from i to end
    ; swap element at i with min
    ; increment i, repeat till the end
    (define (main-loop i)
      (cond [(> i n) vect]
            [else (let ((min-i (find-min-index vect i i)))
                    (begin (swap i min-i vect)
                           (main-loop (+ i 1)))
                    )]
            )
      )
    (main-loop 0)
    
    )  
  )
(selection-sort-v2 (vector 4 2 7 1 3))

; ANALYSIS
; selection sort -> n^2
; same as bubble, but selection is much more smarter

#|
2 layers of selection sort
say ther are 5 element inan array (n=5)

COMPARISON: find minimum thing (identical to bubblesort)
pass1 -> atmost n-1 comparison (4)
pass2 -> 3
pass3 -> 2
... n(n-1)/2

SWAP (more efficient)
finds absolute minimum and makes 1 swap per pass
n-1 swaps
where bubblesort swaps elemene continously
n^2/2
|#

; ======================================================

; EXERCISES
#|
1. Use Big O notation to describe the time complexity of an algorithm that
takes 4N + 16 steps.
answre: ignore constant thats just N so time complexity is O(n)

_

2. Use Big O notation to describe the time complexity of an algorithm that
takes 2n^2
answer:
ignoring te constant 2 the time complexity is quadratic (n^2)

_

3.  Use Big O notation to describe the time complexity of the following func
tion, which returns the sum of all numbers of an array after the numbers
have been doubled:

def double_then_sum(array):
doubled_array = []
for number in array:
doubled_array.append(number * 2)
sum = 0
for number in doubled_array:
sum += number
return sum

answer:
im not familiar with python but let me try analyze
we have a function that takes array of numbers
double those number and sum it

1st loop -> double each number in array
checks each item and just do n*2 -> so thats n times

2nd loop -> accumulates those doubled and put in the sum
so thats also checking one by one in the array -> n times

so the total is n + n = 2n times
unless im mistaken this is not nested loop where you mult n . n
so time complexity ignoring the constant thats just O(n)

_

4. Use Big O notation to describe the time complexity of the following function,
which accepts an array of strings and prints each string in multiple cases:

def multiple_cases(array):
for string in array:
print(string.upper())
print(string.lower())
print(string.capitalize())

answer:
ok so we have a function that takes array of strings
and printes each string in multiple cases

theres only 1 loop here that iterates through each string
loop -> scans each string -> n
then inside of that we do 3 operations
assuming those 3 operations are instant (1) then we have

n + 3? or maybe 3n
yeah thats 3n since its inside loop (3 . n)
either way it doesn't matter the time complexity is O(n)

_

5.  The next function iterates over an array of numbers. As it does so, it
focuses on every other number while ignoring the numbers in between.
For each “focus number,” the function proceeds to print out every number
from the array—one at a time—after being added to the focus number.
What is this function’s efficiency in terms of Big O notation?

def every_other(array):
for index, number in enumerate(array):
if index % 2 == 0:
for other_number in array:
print(number + other_number)

answer:

ok so we have 2 loops here
outer -> checks everything in array -> n times

inner -> only runs if its even/odd thing -> n/2 times
assuming if and print is like instant

so i guess efficiency is
n . n/2 = n^2/2 -> O(n^2)


|#



