#lang racket

; 0 = 0
; 1 = 1
; 2 = 2
; 3 = 10
; 4 = 11
; 5 = 12
; 6 = 20
; 7 = 21
; 8 = 22
; 9 = 100
; 10 = 101 ...

; Any -> Boolean
; checks if a given item is a ternary
(define (is-ternary? n)
  (or (eq? n 0)
      (eq? n 1)
      (eq? n 2))
  )

; String -> Number
(define (to-decimal s)
  (let ((seq (string->list s)))
    (define (chars-to-lon chars)
      (map (lambda (char) (let ((num (- (char->integer char) (char->integer #\0)))) num) ) seq)
      )
    
    (let ((lon (chars-to-lon seq)))
      (foldl (lambda (d acc) (cond [(not(is-ternary? d)) 0]
                                   [else (+ (* 3 acc) d) ])) 0 lon)
      )
    )   
  )
(to-decimal "102012") ; should return 302
(to-decimal "ege")
(to-decimal "abc")