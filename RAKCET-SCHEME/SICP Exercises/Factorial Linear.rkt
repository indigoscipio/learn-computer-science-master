#lang sicp


(define (factorial x)
  
  (define (iter total counter)
    (if (> counter x)
        total
        (iter (* total counter)(+ counter 1))))
   
      (iter 1 1)
    )
  



(define (+ a b) 
  (if (= a 0) 
      b 
      (+ (dec a) (inc b))))


(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1) (A x (- y 1))))))

(define (f n) (A 0 n))
(define (g n) (A 1 n))

