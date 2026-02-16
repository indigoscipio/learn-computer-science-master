#lang sicp

(define (* a b)
  (if (= b 0)
      0
      (+ a (* a (- b 1)) )
      )
  )



(define (fast-mul a b)

  (define (iter a b result)
    
  (cond ((= b 0) result)
        ;;if b is even, use double & hlaf thing
        ((even? b) (iter (double a) (halve b) result ))
        ;;else reduce b by 1 until its even
        (else (iter (double a) (halve (- b 1)) (+ a result)) ))
    )
  
  (iter a b 0)
  )

(define (double x)
  (* 2 x)
  )

(define (halve x)
  (/ x 2)
  )

(define (even? x)
  (= (remainder x 2) 0)
  )

(fast-mul 2 3)