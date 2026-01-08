#lang racket

(define units '(one two three four five six seven eight nine))
(define teens '(ten eleven twelve thirteen fourteen fiveteen sixteen seventeen eighteen nineteen))
(define tens '(twenty thirty fourty fifty sixty seventy eighty ninety))


; digits2:: number -> pair of number number
; given a number, extracts its tens and unit digit
(define (digits2 n)
  (cons (quotient n 10) (remainder n 10))
  )

;; combine2: number number -> symbol
; given two one digit number, t and u, converts those into correct english language
(define (combine2 t u)
  ; single digit: if t = 0, lookup unit
  ; teens: if t = 1 , lookup teens
  ; tens: if t >= 2, lookup tens
  ; tens + units and t >= 2, tens + units
  (cond [(= t 0) (list-ref units (- u 1))]
        [(= t 1) (list-ref teens u)]
        [(>= t 2) (if (= u 0)
                      (list-ref tens (- t 2))
                      (list (list-ref tens (- t 2)) (list-ref units (- u 1)))
                      ) ]
        )
  )
(combine2 0 2)
(combine2 5 0)
(combine2 1 9)
(combine2 3 0)
(combine2 4 7)

; convert2:: number -> symbol
; given a two digit number, properly converts them into english language
(define (convert2 n)
  (let ((u (cdr (digits2 n)))
        (t (car (digits2 n)))
        )
    (combine2 t u)
    )
  )
(convert2 58)

(define (digits3 n)
  (cons (quotient n 100) (remainder n 100) )
  )


(define (combine3 h t)
  (cond [(= h 0) (convert2 t)]
        [(= h 1) (if (= t 0)
                     (list (list-ref units t) 'hundred)
                     9999
                     )]
        [else 2])
  )
(combine3 0 58)
(combine3 1 0)