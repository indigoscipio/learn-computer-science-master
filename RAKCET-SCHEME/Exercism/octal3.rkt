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
      (andmap (lambda (d) (<= 0 d 7)) l)
      )
    
    ; using accumulator/iter
    ; acc stores the decimal value accumulated so far
    ; List-of-numbers -> List-of-numbers   
    (define (iter lon acc)
      (cond [(null? lon) acc]
            [else (iter (cdr lon) (+ (car lon) (* acc 8)) ) ])
      )


    ; iteration 2, using basic linear recursion
    ; no accumulator
    (define (convert l)
      (cond [(empty? l) 0]
            [else (+ (* (first l) (expt 8 (- (length l) 1)) ) (convert (cdr l)) )])
      )
    (convert lon)
    
    ; iteration 3, using foldr
    (foldr (lambda (n acc) (+ n (* 8 acc)) ) 0 (reverse lon))

  
    ; initialize with base power 0 and reverse the lon, and fold to sum it all
    (if (is-valid-octal-input? lon)
        (foldr (lambda (n acc) (+ n (* 8 acc)) ) 0 (reverse lon))
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
