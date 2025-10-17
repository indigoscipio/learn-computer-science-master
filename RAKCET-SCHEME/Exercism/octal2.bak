#lang racket

; Converts an octal to decimal number representation
; String -> Number
(define (to-decimal s)
  (let* ((octal-digits '(0 1 2 3 4 5 6 7))
         (chars (string->list s))
         (lon (map (lambda (char) (- (char->integer char) (char->integer #\0))) chars))
         )

    ;handle validation
    (define (is-valid-octal-input? l)
      (cond [(null? l) #t]
            [(not (member (car l) octal-digits)) #f]
            [else (is-valid-octal-input? (cdr l))])
      )   
    
    ; using accumulator/iter
    ; acc stores the decimal value accumulated so far
    ; List-of-numbers -> List-of-numbers   
    (define (iter lon power acc)
      (cond [(null? lon) acc]
            [else (iter (cdr lon) (add1 power) (+ (* (car lon) (expt 8 power)) acc) ) ])
      )
    
    ; initialize with base power 0 and reverse the lon, and fold to sum it all
    (if (is-valid-octal-input? lon)
        (iter (reverse lon) 0 0)
        0
        )
    )
  )

(to-decimal "1735263")
(to-decimal "233")
(to-decimal "7777")
(to-decimal "98890")
; 3 * 8^0
; 3 * 8^1
; 2 * 8^2
; then sum everything -> 155 (decimal)