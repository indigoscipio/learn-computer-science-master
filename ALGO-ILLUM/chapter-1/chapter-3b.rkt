#lang racket

;CHAPTER 3

; a Result is a (list merged-list inversion-count)
; where merged-list is a list of numbers
; and inversion count is a number

; list-of-x list-of-y -> Result
(define (merge xs ys)
  (cond [(null? xs) (list ys 0)]
        [(null? ys) (list xs 0)]
        [else (if (< (car xs) (car ys))
                  (let* ((rec-result (merge (cdr xs) ys))
                         (res-merge (car rec-result))
                         (res-count (cadr rec-result))
                         )
                    (list (cons (car xs) res-merge) res-count) ;put in front
                    )
                  (let* ((rec-result (merge xs (cdr ys)))
                         (res-merge (car rec-result))
                         (res-count (cadr rec-result)))
                    (list (cons (car ys) res-merge) (+ res-count (length xs)) )
                    )
                  )]
        )
  )
(merge '(1 4 6) '(2 3 7))


(define (merge-tail xs ys)
  ; on each iteration, build the list
  (define (merge-tail-helper lst0 lst1 lst-acc count-acc)
    ;iknow we need to reverse lst-acc at end butfornow letskeepthis
    (cond [(null? lst0) (list (append (reverse lst-acc) lst1 ) count-acc)]
          [(null? lst1) (list (append (reverse lst-acc) lst0 ) count-acc)]
          [else (if (> (car lst0) (car lst1))
                    (merge-tail-helper lst0
                                       (cdr lst1)
                                       (cons (car lst1) lst-acc)
                                       (+ (length lst0) count-acc)
                                       ) ;lst0 out of order
                    (merge-tail-helper (cdr lst0)
                                       lst1
                                       (cons (car lst0) lst-acc)
                                       count-acc
                                       ) ;lst0 in correct order
                    )]
          )
    )
  (merge-tail-helper xs ys '() 0)
  )
(merge-tail '(1 4 6) '(2 3 7))
(merge-tail '(1) '(4 5 6))

; given a list of length n, splits the list into two with length n/2
; list-of-x -> listof-list-of-x
(define (split xs)
  (let* ((n (quotient (length xs) 2))
         (first-half (take xs n) )
         (second-half (drop xs n))
         )
    (list first-half second-half)
    )
  )

; MERGE SORT
; list-of-x -> Result
(define (mergesort xs)
  (let* ((split-xs (split xs))
         (first-half (car split-xs))
         (second-half (cadr split-xs)))
    (cond [(null? xs) (list '() 0)]
          [(null? (cdr xs)) (list xs 0)] ; only one item
          [else (let* ((first-res (mergesort first-half))
                       (first-sorted (car first-res))
                       (first-count (cadr first-res))
                       (second-res (mergesort second-half))
                       (second-sorted (car second-res))
                       (second-count (cadr second-res))
                       (merge-res (merge first-sorted second-sorted))
                       (merge-sorted (car merge-res))
                       (merge-count (cadr merge-res))
                       )
                  (list merge-sorted
                        (+ merge-count first-count second-count)))])
    )
  )
(mergesort '(3 1 5 0 8 99))

; v2, with mergesort
; n log n implementation
(define (count-inversions-v2 xs)
  0
  )
(count-inversions-v2 '(1 3 5 2 4 6))

; helper
; number list-of-number -> number
(define (count-inversion x xs)
  (cond [(null? xs) 0]
        [(> x (car xs)) (+ 1 (count-inversion x (cdr xs)))] ;out of order
        [else (count-inversion x (cdr xs))]
        )
  )
(count-inversion 3 '(1 2))

; INVERSIONS
; how out of order is an array?
; normal way
(define (count-inversions xs)
  (cond [(null? xs) 0]
        [else (let ((fst (car xs))
                    (rest (cdr xs))
                    )
                (+ (count-inversion fst rest) (count-inversions rest) )
                )]
        )
  )
(count-inversions '(3 1 2)) ; i0 vs 1, i0 vs 2, 2 inversions
(count-inversions '(1 3 5 2 4 6)) ;???
(count-inversions '(1 2 3)) ; 0 inversions

#|
Quiz 3.1
What ist he largest posible inversions of a 6 element array can have?

answer:
ok so we have lets day
6 5 4 3 2 1 which is completely sorted in opposite way

let x be the curr number and i is the counter for the inversion
so n = 6, x = 6, i = 0
first check 6
(6,5) -> +1
(6,4) -> +1
(6,3) -> +1
(6,2) -> +1
(6,1) -> +1
total = 5

next x = 5, i = 5
(5,6) -> 0
(5,4) -> +1
(5,3) -> +1
(5,2) -> +1
(5,1) -> +1
total inversion = 4

so its like the sum
5+4+3+2+1 -> 15

|#

#|
QUIZ 3.2
SupposetheinputarrayAhasnosplit inversions.What istherelationshipbetweenthesortedsubarraysCandD?

a)ChasthesmallestelementofA,Dthesecond-smallest,
Cthethird-smallest,andsoon.
b)AllelementsofCarelessthanallelementsofD.
c)AllelementsofCaregreaterthanallelementsofD.
d)Thereisnotenoughinformationtoanswerthisques
tion.

answer:
ok so input array A has no split inversion
we wanna know relationship between sorted subarray c and d

if c and d is already sorted
lets say c = {4 6 8}
d = {1 2 3}

4 < 1? false
so thatmeans we found inversion of length d

wht sxactly here is array A? notsure
zero split inversion =
every single element in C is smaller than every single element in D

an inversion happens when:
LEFT ELEMENT > RIGHT ELEMENT

|#