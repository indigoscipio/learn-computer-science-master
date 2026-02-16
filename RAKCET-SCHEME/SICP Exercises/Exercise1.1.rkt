#lang sicp


;F(n) = n if n < 3
;F(n) = F(n - 1) + 2f(n - 2) + 3f(n - 3) if n 2 >= 3

;recursive process
(define (rec-func n)
  (if (< n 3)
      n
      (+
       (rec-func (- n 1))
       (* 2 (rec-func (- n 2)))
       (* 3 (rec-func (- n 3)))
       )
     )
  )


;iterative process
 (define (f n) 
   (define (iter a b c count) 
     (if (= count 0) 
       a 
       (iter b c (+ c (* 2 b) (* 3 a)) (- count 1)))) 
   (iter 0 1 2 n))


(f 8)