#lang racket

; Exercise 2.2
; What are the permissible argument values for which you should show that it works?
; code from the book

(define factorial
  (lambda (n)
    (if (= n 1)
        1
        (* (factorial (- n 1))
           n))))


; arguments needed are nonnegative intger

; base case is 0! = 1
; doesnt recurse

; inductive hypothesis
; assume (factorial k) works for k<n

; inductive step
; show (factorial n) computes n! using assumption for (factorial (n-1))
; termination is guaranteed because each recursive call reduces n by 1

; example: factorial 3
; checks if n = 1, false
; runs recursive case, do (* (factorial 2) 3)
; inside factorial 2
; checks if n =1, false, runs recursive case, do (* (factorial 1) 2)
; finally, checks if n = 1, true, return 1
; compute everything, returns 3 * 2 * 1 = 6

; =============================

; Exercise 2.3

(define square ; another version that doesn’t work
  (lambda (n)
    (if (= n 0)
        0
        (+ (square (- n 1))
           (- (* 4 n) 4))
        )
    )
  )


; Base case
; if n = 0 -> 0^2 = 0

; Inductive hypothesis
; assume (square k) works for smaller k < n

; Inductive step
; show that  (square n) = n^2 using (square (n - 2))
; the problem is when we ust n = 1, it goes negative -> square(-1)
; the base case never reached and it can never terminates

; let n =1
; (square 1)
; checks if n = 0, false
; goes into recursive case
; (+ (square (-1)) 0)
; then inside square -1
; checks if n = 0, false
; goes into recursive case again
; (+ (square (-3)) -8), etc

; Exercise 2.4
;Use one-layer thinking to help you correctly fill in the blanks in the following version
;of square so that it can square any nonnegative integer:

#|
(define square
  (lambda (n)
    (if (= n 0)
        0
        (if (even? n)
            (* (square (/ n 2)) 4)
            (+ (square (- n 1))
               (- (+ n n) 1))
            ))))
|#

; lets say n is even, lets pick 2
; it reaches the recursive case -> runs (? (square (/ 2 2)) ?)
; from 2 we need to reach the base case 0 and return 2^2 = 4 how do we do that
; we know next call is (square (/ 2 2)) = square(1)-> return odd case recursion
; (+ (square 0) 1) = 1

; assume (square (n/2)) correctly returns (n/2)^2
; how do you get n^2 from (n/2)^2
; (n/2)^2 = n^2/4 but we want n^2
; multiply it by 4 to get n^2
; therefore 4


(define (quot n d)
  ; base case
  (cond [(< n d) 0]
        [else (+ (quot (- n d) d) 1)])
  ;
  )
(quot 9 3) ;3
(quot 10 3) ; 3