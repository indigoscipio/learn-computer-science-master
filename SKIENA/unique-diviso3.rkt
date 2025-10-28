#lang racket


; Exercise 1-28
; integer division without using / or *
; trace example: 24 / 4
; 24 - 4
; 20 - 4
; ...
; 4 - 4
; 0 < 4? return result

; Number Number -> Number
; performs division without using / or *
; where a is the dividend and b is the divisor
; basically like (quotient) in scheme?
(define (div a b)

  ; Number Number -> (cons Number Number)
  (define (find-biggest-chunk dividend chunk times)
    (cond [(> (* chunk 2) dividend) (cons chunk times)]
          [else (find-biggest-chunk dividend (* chunk 2) (* times 2))]
          )
    )
  
  
  (define (loop dividend divisor quotient)
    (cond [(< dividend divisor) quotient]
          [else (loop (- dividend divisor) divisor (+ 1 quotient)) ])
    )

  (find-biggest-chunk 50 6 1)

  #|
  ; handle case where b = 0
  (if (= b 0)
      (error "b can't be 0")
      (let* ((sign (if (or (and (negative? a) (negative? b))
                           (and (positive? a) (positive? b))) 1 -1) )
             (quotient (loop (abs a) (abs b) 0) )
             )
        (* sign quotient)
        )
      )
  |#

  )
(div 24 -4) ; should return 6
(div 32 5) ; should return 6
; (div 24 0) ; return error