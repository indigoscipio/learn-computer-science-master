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
    ; accumulator acc holds the final value in decimal
    (define (iter l acc)
      (cond [(empty? l) acc]
            [else (let ((curr-num (- (char->integer (car l)) (char->integer #\0)) ))
                    (cond [(not (is-ternary? curr-num)) 0 ]
                          [else (iter (cdr l) (+ (* 3 acc) curr-num))])
                    )]
            )
      )
    ;(iter seq 0)

    (define (chars-to-lon chars)
      (map (lambda (char) (let ((num (- (char->integer char) (char->integer #\0)))) num) ) seq)
      )
    ; iteration 2: using higher order function
    (let ((lon (chars-to-lon seq)))
      (foldl (lambda (d acc) (cond [(not(is-ternary? d)) 0]
                                   [else (+ (* 3 acc) d) ])) 0 lon)
      )
    
    )   
  )
(to-decimal "102012") ; should return 302
(to-decimal "ege")
(to-decimal "abc")