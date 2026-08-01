#lang racket

; QUICKSORT
; does the hard work up front
; picks pivot element
; smaller than pivot? go left. larger? go right
; recursively sort the two sides
; + NO NEED TO COMBINE

; DIFFERENCE VS MERGESORT;
; merge -> divide blindly, then sort/stitch (merge)
; quick -> partition around pivot first

; HOW IT WORKS
; 1. choose pivot
; 2. rearrange input basedo n pivot
; 3. divide into first part (smaller than pivot), second part (larger than pivot)
; 4. once done, drop the pivot (pivot alaready sorted)

; PICKING PIVOT
; first element (naive)
; random element
; median of three

; =============================

; PARTITION
; partition:: list-of-number -> list-of-list-of-number
(define (partition pivot xs)
  (define (partition-helper curr-xs small-xs large-xs)
    (cond [(null? curr-xs) (list small-xs large-xs)]
          [else (let* ((curr-val (car curr-xs)))
                  (if (> curr-val pivot)
                      (partition-helper (cdr curr-xs)
                                        small-xs
                                        (cons curr-val large-xs)) ;put in large
                      (partition-helper (cdr curr-xs)
                                        (cons curr-val small-xs)
                                        large-xs
                                        ) ;put in small
                      )
                  )
                ])
    )
  (partition-helper xs '() '())
  )
(partition 4 '(0 1 2 3 7 8 9)) ; '((0 1 2)(7 8 9)) 

; MAIN FUNCTION
; list/functional style
(define (quicksort xs)

  #|
  ; lets just cdr down for simplicity
  ; naive pivot pick
  (cond [(null? xs) '()]
        [else (let* ((pivot (car xs))
                     (partition-res (partition pivot (cdr xs)))
                     (small-xs (car partition-res))
                     (large-xs (cadr partition-res))
                     )
                (append (quicksort small-xs)
                        (list pivot)
                        (quicksort large-xs))
                )]
        )
  |#

  
  ; random pivot pick
  (cond [(null? xs) '()]
        [else (let* ((pivot (list-ref xs (random (length xs))) )
                     (partition-res (partition pivot (remove pivot xs)))
                     (small-xs (car partition-res))
                     (large-xs (cadr partition-res)))
                
                (append (quicksort small-xs)
                        (list pivot)
                        (quicksort large-xs))
                
                )]
        )
  
  )
(quicksort '(-10 5 11 -1 0 8 99))

; imperative/vector style
(define (quicksort-v2 vect)
  (let ((n (- (vector-length vect) 1)))

    (define (swap! i j v)
      (let ((temp-i (vector-ref v i)))
        ; temp-i = i -> i = j => j = temp-i
        (begin (vector-set! v i (vector-ref v j))
               (vector-set! v j temp-i)
               v)
        )
      )
    
    
    ; partition
    ; number number vector -> vector
    (define (partition l r v)
      ; pick pivot
      ; scan through (l+1) to r
      (let ((pivot (vector-ref v l))
            (i (+ l 1)))

        (for ((j (in-range i (+ r 1))))
          (when (< (vector-ref v j) pivot)
            (begin (swap! i j v)
                   (set! i (+ i 1)))
            )
          )

        (swap! l (- i 1) v)
        (- i 1)
        
        )
      )
    

    ; main function
    (define (quicksort-helper l r v)
      (cond [(>= l r) v]
            [else (let ((p (partition l r v) ))
                    (begin (quicksort-helper l (- p 1) v)
                           (quicksort-helper (+ p 1) r  v)))]
            )
      )
    (quicksort-helper 0 n vect)
    
    )
  )
(quicksort-v2 (vector -10 5 11 -1 0 8 99))


#|
Quiz5.1
WhatistherunningtimeoftheQuickSortalgorithm,with
thenaive implementationof ChoosePivot, when then
element inputarrayisalreadysorted?

a)O(n)
b)O(n log n)
c)O(n^2)
d)O(n^3)


ok so we know it does like 2 recursive calls
quicksort the left part, quicksort the left part
both excludes the pivot
so a = 2


and for the problem shrinkage, each call to itself
divides the input by 2 so b = 2 also

and the work done outside is like simple comparison
and for the partition depends on the pivot im guessing
since this is worst case with naive the pivot is the first
item in the list so its gotta check the remaining items
so maybe worst case for naive its n? so maybe d = 1??

so im guessing its either b or c here not sure

correction
for b since the pivot is always the first
it does not dividei n half but rather 'chop off' the left bit by bit
similar to a normal n performance

so its

T(n-1) + O(n)
N^2

; ===================================================

QUIZ 5.2
what is the running time of the quicksort algorithm with
theoverkill implementationof ChoosePivot, onanarbi
traryn-elementinputarray?AssumethattheChoosePivot
subroutinerunsin⇥(n)time.

answer:
a) Insufficient informationtoanswer
b)O(n)
c)O(nlogn)
d)O(n^2)

answer:

|#


; ===================================================

#|
RANDOMIZED QUICKSORT
- always runs in n log n
- dont need a 5050 split
- 25/75 or 75/25 is fine
- even if its a shit coin toss next one will be good


Total Time (RT) <= a x Comparisons


|#

#|
Fixtwodifferentelementsoftheinputarray, sayzi andzj.
Howmanytimesmightzi andzj becomparedwitheach
otherduringtheexecutionofQuickSort

a) exactlyonce
b) 0or1times
c) 0,1,or2times
d) anynumberbetween0andn-1ispossible

answer:
either 0 or 1?

0 times -> if anelement betwen zi and zj it gets picked , splits into 2 subarray
once seperated, they can never see each other again

1 times -> if either zi or zj is picked as the pivot while still
in the subarray, they compared exactly once

|#

; ===================================================

#|
Problem5.1Recall the Partition subroutine employed by
QuickSort(Section5.2).Youaretoldthatthefollowingarrayhas
justbeenpartitionedaroundsomepivotelement:

3 1 2 4 5 8 7 6 9

Whichoftheelementscouldhavebeenthepivotelement? (Listall
thatapply; therecouldbemorethanonepossibility.)

answer:
5 could have been the pivot
3 1 2 4 | 5 | 8 7 6 9

also 4 -> 3,1,2 smaller than 4 and 5 8 7 6 9 is bigger than 4 
9 -> 3 1 2 4 5 8 7 6 is smaller than 9
3 -> cannot be pivot
8 -> cannot be, 6 < 8

so its 5 4 9?? notsure

_

5.2
Problem5.2Let↵besomeconstant,independentoftheinputarray
lengthn,strictlybetween0and1
2.Whatistheprobabilitythat,with
arandomlychosenpivotelement,thePartitionsubroutineproduces
asplit inwhichthesizeofboththeresultingsubproblems isat least
↵timesthesizeoftheoriginalarray?

note: ↵ is alpha symbol here in book
a. ↵
b) 1-↵
c) 1-2↵
d) 2-2↵

answer:
1/3 (1- 2 alpha)

_

Problem 5.3 Let ↵ be some constant, independent of the input
array length n, strictly between 0 and 1
2. Assume you achieve the
approximately balanced splits from the preceding problem in every
recursive call—so whenever a recursive call is given an array of length k,
each of its two recursive calls is passed a subarray with length between
↵k and (1-↵)k. How many successive recursive calls can occur before
triggering the base case? Equivalently, which levels of the algorithm’s
recursion tree can contain leaves? Express your answer as a range of
possible numbers d, from the minimum to the maximum number of
recursive calls that might be needed. [Hint: The formula that relates
logarithmic functions with different bases is logb n = ln n /
ln b .]
note: ↵ is alpha symbol here in book

answer:

a.
b.
c.
d.


|#
