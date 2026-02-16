#lang sicp


(define (smallest-divisor n)
  (find-divisor n 2)
  )

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1))))
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



(define (search-for-primes start count)

  (define (iter n primes-found)
    ; stop when the number of primes reaches count         
    ;if n is prime, run time prime test and continue with next odd number
    (cond ((= primes-found count) 'done)
          ((prime? n) (timed-prime-test n) (iter (+ n 2) (+ primes-found 1) ) )
          (else(iter (+ n 2) primes-found )))
    ;if its even, continue with next odd number
    )

  ;initialize iter and ensure it starts with an odd number
  (if (even? start)
      (iter (+ start 1) 0 )
      (iter start 0 )
      )
  
  )

(search-for-primes 1000 3)
(search-for-primes 10000 3)
(search-for-primes 100000 3)
(search-for-primes 1000000 3)
