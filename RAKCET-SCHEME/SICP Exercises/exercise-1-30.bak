#lang racket

(define (cube x)
  (* x x x )
  )

;; simpson-term : Number Function Number Number Number -> Number
;; Given a position k, a function f, step size h, start a, and end index n,
;; computes the weighted y_k = f(a + k*h) * weight
(define (simpson-term k f h a n)
  (* (f (+ a (* k h)))
     (cond [(or (= k 0) (= k n)) 1]
           [(even? k) 2]
           [else 4]
           )
     )
  )
(simpson-term 2 cube 0 0.25 4)

;; simpson-sum : Number Function Number Number Number -> Number
;; Computes the weighted sum of y_k values for k = 0 to n
;; given f (the function), h (step size), a (start), and n (last index)
(define (simpson-sum f h a n)
  (local ((define (loop k acc)
            (cond [(> k n) acc]
                  [else (loop (add1 k) (+ (simpson-term k f h a n) acc))])
            ))
    (loop 0 0)
    )
  )
(simpson-sum cube 0.25 0 4)


;; simpson : (Number -> Number) Number Number Number -> Number
;; Approximates the integral of f from a to b using Simpson's rule with n slices (n must be even)
(define (simpson f a b n)
  (local ((define h (/ (- b a) n)))
  (* (simpson-sum f h a n) (/  h 3)))
  )
(simpson cube 0 1 100)