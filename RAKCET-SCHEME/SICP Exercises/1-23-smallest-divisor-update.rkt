#lang sicp


(define (smallest-divisor n)
  
  (find-divisor n 2)
  )

(define (next test-divisor)
  (if (= test-divisor 2)
      3
      (+ test-divisor 2)
      )
  )

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor))))
  )

(define (square n)
  (* 2 n)
  )

(define (divides? a b)
  (= (remainder a b) 0)
  )

(define (prime? n)
  (= n (smallest-divisor n))
  )

;;SEARCH TEST

(define (timed-prime-test n) 
  (newline) 
  (display n) 
  (start-prime-test n (runtime))
)

(define (start-prime-test n start-time) 
(if (prime? n) 
(report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time) 
(display " *** ")
(display elapsed-time))



(timed-prime-test 1000)
(timed-prime-test 10000)
(timed-prime-test 100000)
(timed-prime-test 1000000)