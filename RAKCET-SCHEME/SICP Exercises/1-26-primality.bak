#lang sicp


; divide lrg with samll
; replace larg n w/ reminder from 1
; repeat step 1 - 2 till reminder is 0
; gcd is the last non zero remainder


(define (euclid-gcd a b)
  (if (= b 0)
      a
      (euclid-gcd b (remainder a b))
      )
  )


;;homework: do it in iterative process

(define (euclid-gcd-iter a b)

  (define (iter a b)
    (cond ((= b 0) a)
          (iter b (remainder a b) ))
    )

  (iter a b)

  )


;b becomes 0
; a > b ; b > remainder of a divided by b