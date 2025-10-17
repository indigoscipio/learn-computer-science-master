#lang racket

; a Row is a list of numbers
; '(1), '(1 1), '(1 3 3 1), etc

; a PC is a list-of-Rows
; '((1), (1 1), (1 3 3 1)), etc

; Adds a number to the end of a row
; Row -> Row
(define (add-at-end n row)
  (cond [(null? row) (cons n '())]
        [else (cons (car row) (add-at-end n (cdr row)))])
  )
; Row -> Row
; adds a number n to the start of a given row
(define (add-at-start n row)
  (cons n row)
  )

; builds next row given a row
; Row -> Row
(define (next-row row)
  (map (lambda (x y) (+ x y)) (cons 0 row) (append row '(0)))
  
  )

; Number -> PC
; generates the first n rows of a pascals triangles
(define (pascals-triangle n)
  #|
  ; iteration 1, using accumulator/iter
  ; accumulator stores the list of rows so far
  ; Number List-of-List-of-Row -> List-of-List-of-Row
  (define (iter num acc)
    (cond [(= num 1) acc]
          [else (iter (sub1 num) (cons (next-row (car acc)) acc))])
    )
  ; initialize with row 1
  (if (zero? n) '() (reverse (iter n '((1)))))
  |#

  ; iteration 2, using fold
  ; build each PC row for each iteration
  (if (zero? n) '() (foldl  (lambda (row acc) (cond [(null? acc) '()]
                                                    [else (cons (next-row (car acc)) acc)]) ) '((1)) (build-list (- n 1) identity)))
  
  )
(pascals-triangle 0)
(pascals-triangle 1)
(pascals-triangle 2)
;(pascals-triangle 3)
;(pascals-triangle 4)
