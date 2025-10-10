#lang racket

; List-of-number Number -> Number
; given a list of coeffs and input val,
; comptues polynomials using horner's rule (efficient version)
(define (horners a x)
  (define (loop c i sum)
    (cond [(null? c) sum]
          [else (loop (cdr c) (- i 1) (+ (car c) (* x sum)) ) ]
          )
    )
  (loop (reverse a) (- (length a) 1) 0)
  )
(horners '(3 2 5) 3) ; 3 + 2x + 5x^2 with input value 3

#|
; List-of-number number -> Number
; given a list of coeficcient and the input value,
; comptues polynomials using naive horners algorithm
(define (horners-naive a x)
  ; List-of-number Number -> Number
  ; on each iteration, store sum current term and accumulate the total
  (define (loop c i sum)
    (cond [(null? c) sum] ;base caseL no more coeficcients, return the final sum
          [else (let* ((power (expt x i))
                      (curr-term (* (car c) power) )
                      )
                  (loop (cdr c) (+ i 1) (+ curr-term sum) )
                  )] ;
          )
    )
  (loop a 0 0)  
  )
(horners-naive '(3 2 5) 3) ;3 + 2x + 5x^2
|#