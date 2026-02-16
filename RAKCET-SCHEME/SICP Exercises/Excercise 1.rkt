#lang sicp


(define (sum-of-two-largest-squares x y z)
  (cond 
         ((and (<= x y) (<= x z))(+ (* y y) (* z z)))
         ((and (<= y x) (<= y z))(+ (* x x) (* z z)))
         (else (+ (* x x) (* y y)))
         
   )
)

(sum-of-two-largest-squares 3 2 3)