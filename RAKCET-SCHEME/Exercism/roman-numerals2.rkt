#lang racket

; M = 1000
; D = 500
; C = 100
; L = 50
; X = 10
; V = 5
; I = 1

; the same letter cannot be used more than three times in sucession
; applies to 4 (IV), 9 (IX), XL (40), 90 (XC), 400 (CD), and 900 (CM)
; letters must be ordered by decreasing value from left to right

; A RomanNumeralPair is a pair of (symbol number)
; '(M 1000), '(D 500)

; A RomanNumeralTable is a list of RomanNumeralPair
(define rnt '((M . 1000) (CM . 900) (D . 500) (CD . 400)
                         (C . 100) (XC . 90) (L . 50) (XL . 40) (X . 10)
                         (IX . 9) (V . 5) (IV . 4) (I . 1)))


; Number -> String
; converts a number into a roman numeral
(define (roman n)
  ; checks if roman value fits n
  ; acc accumulates the final roman numerals symbols
  ; List-of-Number Number List-of-Symbols
  (define (convert l num)
    (cond [(zero? num) '()]
          [else (let* ((pair (car l))
                      (rest (cdr l))
                      (symbol (car pair))
                      (value (cdr pair))
                      )
                  (if (<= value num)
                      (cons (symbol->string symbol) (convert l (- num value) ))
                      (convert rest num)
                      )
                  )])
    )
  (foldr string-append "" (convert rnt n)) 
  )
(roman 1996)