#lang racket

;CHAPTER 4

;; BUBBLE SORT - overview
; pick pair and compare
; swap pair
; shift/move and comapre next pair, repeat until last pair


; BUBBLE SORT
; functional approach (LIST)

; list-of-number -> list-of-number
(define (all-but-last xs)
  (cond [(null? xs) '()] ; lets add this for guard
        [(null? (cdr xs)) '()]
        [else (cons (car xs) (all-but-last (cdr xs)))]
        )
  )
(all-but-last '(1))
(all-but-last '(1 2))
(all-but-last '(1 2 3))

; list-of-x -> list-of-x
; given a list of number, do a single 'bubble' sort pass
(define (bubble xs)
  (cond [(null? xs) '()]
        [(null? (cdr xs)) xs]
        [( > (car xs) (cadr xs)) (cons (cadr xs) (bubble (cons (car xs) (cddr xs)) ))]
        [else (cons (car xs) (bubble (cdr xs)))] ;build normally
        )
  )
(bubble '(5 1 4 2 8)) ; '(1 4 2 5 8)

; list-of-number -> list-of-number
(define (bubble-sort-v1 lst)

  #|
  ; using list building
  (cond [(null? lst) '()]
        [(null? (cdr lst)) lst]
        [else (let ((curr-bubble-pass (bubble lst)))
                (append (bubble-sort-v1 (all-but-last curr-bubble-pass))
                        (list (last curr-bubble-pass)))
                ) ]
        )
  |#

  ; using n-1
  (define (bubble-sort-v1-helper xs n)
    (cond [(zero? n) xs]
          [else (let((curr-pass (bubble xs)))
                  (bubble-sort-v1-helper curr-pass (- n 1))
                  )]
          )
    )
  (bubble-sort-v1-helper lst (- (length lst) 1))
  
  )
(bubble-sort-v1 '(5 1 4 2 8))


; BUBBLE SORT
; imperative approahc (VECTOR)
; two pointers (first two) -> slide these

(define (bubble-sort-v2 vect)
  (let ((n (- (vector-length vect)1)))
    ; outer loop: bubble repeated passes
    ; inner loop: bubble 1x pass

    ; a = i, b = i+1
    ; vector number number -> vector
    (define (bubble v i i+1)
      (cond [(> i+1 n) v] ;done
            [else (let ((a-val (vector-ref v i))
                        (b-val (vector-ref v i+1)))
                    (if (> a-val b-val)
                        (let ((temp-a a-val))
                          ;out of order.
                          ; temp var = a-val 
                          ; swap a-val with b-val
                          ; set b-val = temp var
                          (begin (vector-set! v i b-val)
                                 (vector-set! v i+1 temp-a)
                                 (bubble v (+ 1 i) (+ 1 i+1))))
                        (bubble v (+ 1 i) (+ 1 i+1))
                        )
                    )]
            )
      )
    
    ; number -> vector
    (define (bubble-each curr-n)
      (cond [(> curr-n n) vect]
            [else (begin (bubble vect 0 1)
                         (bubble-each (+ curr-n 1)))]
            )
      )


    (let loop ((curr-n 0))
      (cond [(> curr-n n) vect]
            [else (begin (bubble vect 0 1)
                         (loop (+ curr-n 1))
                         )])
      )
    
    )  
  )
(bubble-sort-v2 (vector 5 1 4 2 8))


#|
BUBBLE SORT ANALYSIS

pass 1 -> 4
pass 2 -> 4-1
pass 3 -> 4-1-1
etc

triangular number
1/2 . base . height
n(n-1) / 2
|#


; =================================

; CHECK DUPLICATE
; functional style/list:
; not sure if its even possible with linear n time in functional style?

; CHECK DUPLICATE
; imperative style/vect
(define (has-duplicate-v2 vect)
  (let ((n (- (vector-length vect) 1))
        (table (make-vector 11 #f)))
    
    (define (has-duplicate-helper i)
      (cond [(> i n) #f]
            [else (let ((curr-val (vector-ref vect i)))
                    (if (vector-ref table curr-val)
                        #t
                        (begin (vector-set! table curr-val #t)
                               (has-duplicate-helper (+ i 1)))
                        )
                    )]
            )
      )
    (has-duplicate-helper 0)

    )
  )
(has-duplicate-v2 (vector 1 4 5 2 9)) ;#f
(has-duplicate-v2 (vector 1 4 5 2 1 9)) ;#t


#|
EXERCISES
1. Replace the question marks in the following table to describe how many steps
occur for a given number of data elements across various types of Big O:

N Elements  O(n) O(log N) O(n^2)
100 100 ? ?
2000 ? ? ?

answer:
ok so we know
1st row -> n = 100
O(N) = 100
O(log N) = approx 6.6439 -> 6.6
O(n^2) -> 100^2 = 100 . 100 = 10000

2nd row -> n = 2000
O(n) = 2000
O(log n) = log2 2000 = approx. 10.9
O(n^2) = 2000^2 = 2000 . 2000 = 4,000,000

_

2.If we have an O(N^2) algorithm that processes an array and find that it
takes 256 steps, what is the size of the array?

answer:
ok so we have o(n^2) algorithm which means grows
quadraticaly with input increase

the algorihtm takes 256 steps
n^2 = 256
n = sqrt(256)
n = 16
so the input size is 16

_

3. Use Big O notation to describe the time complexity of the following func
tion. It finds the greatest product of any pair of two numbers within a
given array:

def greatest_product(array):
if len(array) < 2:
return None
greatest_product_so_far = array[0] * array[1]
for index_i, value_i in enumerate(array):
for index_j, value_j in enumerate(array):
if (index_i != index_j and
value_i * value_j > greatest_product_so_far):
greatest_product_so_far = value_i * value_j
return greatest_product_so_far

answer:
ok so we have a function that finds greatest product of any pair
of two number iwthin given array

im not sure how python works but im assuming it just fixes
1 number then compare to rest of the number then move on
to next number then compare to rest of number then return the greast

it has two for loops
outer loop -> fix i -> thats n comparison (exclusing itself)
inner loop -> fix j -> also n comparison (excludint itself?)

each step keep checking if theres a new 'champion'
do this until the end of the array and when its done
return the 'champion'
so total comparison = n . n = n^2

_

4.  The following function finds the greatest single number within an array,
but it has an efficiency of O(N2). Rewrite the function so that it becomes
a speedy O(N):

def greatest_number(array):
if not array:
return None
for i in array:
# Assume for now that i is the greatest:
is_i_the_greatest = True
for j in array:
# If we find another value that is greater than i,
# i is not the greatest:
if j > i:
is_i_the_greatest = False
# If, by the time we checked all the other numbers, i
# is still the greatest, it means that i is the greatest number:
if is_i_the_greatest:
return i

answer:
ok let me analyze this im not familiar with pyhotn
but ill try to rewrite in racket i guess

so we have a function that finds greatest single number within an array
but its in n^2

_

|#

; list-of-number -> list-of-number
; i could just write with (apply max args) also but notsure if its linear
(define (greatest-number xs)

  ; method 1: use max
  ; (apply max xs)


  ; method 2: recursive 
  (define (loop curr-xs champ)
    (cond [(null? curr-xs) champ]
          [(> (car curr-xs) champ) (loop (cdr curr-xs) (car curr-xs))]
          [else (loop (cdr curr-xs) champ)]
          )
    )
  (loop (cdr xs) (car xs))


  )
(greatest-number '(1 2 3 4 5 6 7))

; im curious if theres an even faster approach here faster than O(n)?
; maybe divide and conquer? is log n even possible??
; not possible -> needs to be organized/sorted first