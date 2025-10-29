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
  ; finds largest multiple of divisor that fits into current dividend (chunk diivdend)
  ; and how many times that divisor was used to make it (chunk quotient)
  (define (find-biggest-chunk dividend chunk times)
    (cond [(> (* chunk 2) dividend) (cons chunk times)]
          [else (find-biggest-chunk dividend (+ chunk chunk) (+ times times))]
          )
    )
  
  
  (define (loop dividend divisor quotient)
    (cond [(< dividend divisor) quotient]
          [else (let* ((chunk (find-biggest-chunk dividend divisor 1))
                       (chunk-dividend (car chunk))
                       (chunk-quotient (cdr chunk))
                       )
                  (loop (- dividend chunk-dividend) divisor (+ chunk-quotient quotient))
                  ) ] )
    )

  
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
 

  )
(div 24 -4) ; should return 6
(div 32 5) ; should return 6
; (div 24 0) ; return error