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
(define rnt (list (cons 'M 1000) (cons 'CM 900) (cons 'D 500) (cons 'CD 400)
                  (cons 'C 100) (cons 'XC 90) (cons 'L 50) (cons 'XL '40) (cons 'X 10)
                  (cons 'IX 9) (cons 'V 5) (cons 'IV 4) (cons 'I 1)))


; Number -> String
; converts a number into a roman numeral
(define (roman n)
  ; checks if roman value fits n
  ; acc accumulates the final roman numerals symbols
  ; List-of-Number Number List-of-Symbols
  (define (iter l num acc)
    (let ((first-pair (car l))
          (rest-pair (cdr l))
          )      
      (cond [(zero? num) (reverse acc)]
            [(<= (cdr first-pair) num) (iter l (- num (cdr first-pair)) (cons (symbol->string (car first-pair)) acc))]
            [else (iter (cdr l) num acc)]
            )
      )
    )
  (apply string-append (iter rnt n '()))
  ;fix the structure
  ;(foldr (lambda (s acc) (string-append s acc) ) "" (map symbol->string (iter rnt n '())))  
  )
(roman 1996)