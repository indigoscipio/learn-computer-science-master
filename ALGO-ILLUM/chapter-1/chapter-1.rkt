#lang racket

(define (count-digits n)
  (string-length (number->string n))
  )

; 1.3.3
; recincmult
; number -> number
; performs 4 recursive per call
(define (recintmult x y)
  ; 5678 -> remainder 100
  (cond [(and (< x 10) (< y 10)) (* x y)] ; base: single digit
        [else (let* ((n (count-digits (max x y)))
                     (half-magnitude (expt 10 (quotient n 2)) )
                     (a (quotient x half-magnitude))
                     (b (remainder x half-magnitude))
                     (c (quotient y half-magnitude))
                     (d (remainder y half-magnitude))
                     )
                (+ (* (sqr half-magnitude) (recintmult a c))
                   (* half-magnitude (+ (recintmult a d) (recintmult b c)))
                   (recintmult b d))
                )]
        )
  )
(recintmult 12 12)

; karatsuba multiplication
; optimized ver of recintmult
; only performs 3 recursive per call
(define (karatsuba x y)
  (cond [(and (< x 10) (< y 10)) (* x y)] ; base: single digit
        [else (let* ((n (count-digits (max x y)))
                     (half-magnitude (expt 10 (quotient n 2)) )
                     (a (quotient x half-magnitude))
                     (b (remainder x half-magnitude))
                     (c (quotient y half-magnitude))
                     (d (remainder y half-magnitude))
                     (p (+ a b))
                     (q (+ c d))
                     (ac (karatsuba a c))
                     (bd (karatsuba b d))
                     (pq (karatsuba p q))
                     (adbc (- pq ac bd))
                     )
                (+ (* (sqr half-magnitude) ac)
                   (* half-magnitude adbc)
                   bd)
                )]
        )
  )
(karatsuba 12 12)

; ===================================================================

; MERGE
; give a sorted list xs and ys
; merges them into one list
; listof-x listof-y -> list-of-x
(define (merge xs ys)
  (cond [(null? xs) ys]
        [else (cons (car xs) (merge (cdr xs) ys))])
  )
(merge '() '(1)) ;'(1)
(merge '(1 2 3) '(4 5 6)) ;'(1 2 3 4 5 6)
(merge '(1) '(2)) ; '(1 2)

; given a list of length n, splits the list into two with length n/2
; list-of-x -> listof-list-of-x
(define (split xs)

  )
(split '()) ; '(() ()) -> empty
(split '(1 2 3)) ; '((1 2)(3)) -> odd
(split '(1 2 3 4 5 6)) ; '((1 2 3) (4 5 6)) -> even

; MERGE SORT
; divide -> conquer -> combine
; glue together 2 list that's already sorted
; sort first half, sort second half, merge
(define (mergesort xs)
  
  )
(mergesort '())
(mergesort '(11 3 9))
(mergesort '(9 5 7 1 12 5 8 7 1 3 6))



#|
Quiz 1.1

Roughly how many levels does this recursion tree have, as a function of the length
n of the input array?
a. constatnt number independent ofn 
b. log2 n
c. sqrt(n)
d. n

quiz 1.2
|#