#lang racket

#|
4-10. [5] Given a set S of n integers and an integer T,giveanO(nk−1logn) algorithm
to test whether k of the integers in S add up to T

|#

(define (binary-search xs target)
  (define (helper low high)
    (if (> low high)
        #f
        (let* ([mid (quotient (+ low high) 2)]
               [mid-val (list-ref xs mid)])
          (cond [(= mid-val target) #t]
                [(< mid-val target) (helper (+ mid 1) high)]
                [else (helper low (- mid 1))]))))
  (helper 0 (- (length xs) 1)))

; assume the input is already sorted
(define (k-sum sorted-list k target)
  (define (loop xs i remaining-target)
    (cond [(= i 1) (binary-search xs remaining-target)]
          [(< (length xs) i) #f]
          [else (let* ((x (car xs)))
                  (or (loop (cdr xs) (- i 1) (- remaining-target x)) ; pick X
                      (loop (cdr xs) i remaining-target) ; wihout picking X
                      )
                  )]
          )
    )
  ; initalize with i = k
  (loop sorted-list k target)
  
  )
(k-sum '(1 4 6 10 15) 3 11)