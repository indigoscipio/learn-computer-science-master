#lang racket

; a Matrix is a [list-of-Rows]
; a Column is a [list-of-Symbol]
; a Row is a [list-of-Symbol]

;; pad-row : Row Number -> Row
;; Pads the given row with spaces until it reaches the desired length
(define (pad-row row num)
  #|
  ; iteration 1, using tail iter
  (define (iter n acc)
    (cond [(zero? n) acc]
          [else (iter (sub1 n) (cons "" acc))])
    )

    (let ((padding (iter (abs (- (length row) num)) '())))
    (iter padding '())
    )
  |#

  ; with build-list
  (append row (build-list (abs (- (length row) num)) (lambda (i) "")))
  )



; Matrix -> Matrix
; normalizes a matrix length so it's the same as the longest
(define (normalize-matrix m)
  (if (null? m) '()

      #|
      (let ((longest-row (apply max (map length m))))
        ; using iter
        (define (iter l acc)
          (cond [(null? l) (reverse acc)]
                [else (iter (cdr l) (cons (pad-row (car l) longest-row) acc)) ])
          )
        (iter m '())
        )
      |#

      ; Iteration 2, using map
      (let ((longest-row (apply max (map length m))))
        (map (lambda (row) (pad-row row longest-row )) m)
        )

      
      )

  ) 
;(normalize-matrix '((A B C)(A B)(A)))

; Matrix -> Matrix
;; Given a matrix (list of rows), return a new matrix where each row becomes a column and each column becomes a row.
(define (transpose matrix)
  (let ((normalized (normalize-matrix matrix)))
    #|
    ; iteration 1, using tail recursion
    (define (iter m acc)
      (cond [(null? m) (reverse acc)]
            [(null? (car m)) (reverse acc)]
            [else (iter (map cdr m) (cons (map car m) acc) ) ])
      )
    (iter normalized '())
    |#

    ; iteration 2, using map
    (build-list (length normalized) (lambda (i) (map (lambda (row) (list-ref row i)) normalized)))

    ; Iteration 3, using nested map
    (map (lambda (index) (map (lambda (row) (list-ref row index)) normalized) ) (build-list (length normalized) (lambda (i) i)) )
    
    ; iteration 3, using structural recusion
    ; build new row on each iteration
    (define (loop rows)
      (cond [(null? rows) '()] ;stop when rows is empty
            [(null? (car rows)) '()]
            [else (cons (map car rows) (loop (map cdr rows)) )]
            )
      )
    (loop matrix)
    
    )
  )
(transpose '())
(transpose '((65 49) (25 67)))