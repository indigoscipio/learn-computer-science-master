#lang racket

; builds a list of increasing number from a  to b
; Number Number -> List-of-number
(define (enumerate a b)
  (cond [(> a b) '()]
        [else (cons a (enumerate (+ 1 a) b)) ]
        )  
  )


; Number -> Number
; computes the square of sum of n
(define (square-of-sum n)
  (let ((list (enumerate 1 n)))
    ; iteration 1, using accumulator
    (define (iter l acc)
      (cond [(null? l) acc]
            [else (iter (cdr l) (+ (car l) acc))])
      )
    (expt (iter list 0) 2)
  

    ; iteration 2, using recursion
    (define (compute-sum x)
      (cond [(zero? x) 0]
            [else (+ x (compute-sum (- x 1)))])
      )
    (expt (compute-sum n) 2)

    ; iteration 3, using fold
    (expt (foldr + 0 list) 2)

    
    )
  )
(square-of-sum 10) ; should return (1+2+...+10)^2


; Number -> Number
; computes the sum of squares of n
(define (sum-of-squares n)
  (let ((list (enumerate 1 n)))
    ; iteration 1, using accumulator
    (define (iter l acc)
      (cond [(null? l) acc]
            [else (iter (cdr l) (+ (expt (car l) 2) acc))])
      )
    (iter list 0)
 

    ; iteration 2, using recursion
    (define (compute-sum x)
      (cond [(zero? x) 0]
            [else (+ (expt x 2) (compute-sum (- x 1)))])
      )
    (compute-sum n)

      ; iteration 3, using foldr
  (foldr (lambda (x acc) (+ (expt x 2) acc)) 0 list)
    )
  )
(sum-of-squares 10) ; should return 1^2 + 2^2 + ... + 10^2


; Number -> Number
; calcuates the difference of squares
(define (difference-of-squares n)
  (- (square-of-sum n) (sum-of-squares n))
  )
(difference-of-squares 10)

