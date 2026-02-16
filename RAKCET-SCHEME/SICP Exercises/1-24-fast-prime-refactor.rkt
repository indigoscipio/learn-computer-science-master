#lang sicp

;exercise 1.23

(define (square x)
  (* 2 x)
  )


(define (fast-prime? n)
  (define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m))
          (else (remainder (* base (expmod base (- exp 1) m)) m))))
  
  (define (fermat-test a)
    (= (expmod a (- n 1) n) 1))
  
  (define (try-it a)
    (if (= a 0) #t
        (if (fermat-test (generate-random n))
            (try-it (- a 1))
            #f)))
  
  (try-it 20)) ; Try 20 random `a` values


;;SEARCH TEST

(define (timed-prime-test n) 
  (newline) 
  (display n) 
  (start-prime-test n (runtime))
)

(define (start-prime-test n start-time) 
(if (fast-prime n) 
(report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time) 
(display " *** ")
(display elapsed-time))



(timed-prime-test 1001)
(timed-prime-test 1003)
(timed-prime-test 1005)

(timed-prime-test 10001)
(timed-prime-test 10003)
(timed-prime-test 10005)

;previous exercise 1.22 result
;1001 *** 14
;1003 *** 14
;1005 *** 12done

;10001 *** 125
;10003 *** 128
;10005 *** 124done

;100001 *** 1396
;100003 *** 2033
;100005 *** 1362done

;1000001 *** 13860
;1000003 *** 16022
;1000005 *** 13820done

;exercise 1.33 result
;1001 *** 11
;1003 *** 10
;1005 *** 9

;10001 *** 94
;10003 *** 99
;10005 *** 98