#lang racket

; a Matrix is a [list-of-Rows]
; a Column is a [list-of-Symbol]
; a Row is a [list-of-Symbol]

;; pad-row : Row Number -> Row
;; Pads the given row with spaces until it reaches the desired length
(define (pad-row row num)
  (define (iter n acc)
    (cond [(zero? n) acc]
          [else (iter (sub1 n) (cons "" acc))])
    )
  (let ((padding (iter (abs (- (length row) num)) '())))
    (append row padding)
    )    
  )


; Matrix -> Matrix
; normalizes a matrix length so it's the same as the longest
(define (normalize-matrix m)
  (if (null? m) '()  (let ((longest-row (apply max (map length m))))
                       ; using iter
                       (define (iter l acc)
                         (cond [(null? l) (reverse acc)]
                               [else (iter (cdr l) (cons (pad-row (car l) longest-row) acc)) ])
                         )
                       (iter m '())
                       ))  
  ) 

; Matrix -> Matrix
;; Given a matrix (list of rows), return a new matrix where each row becomes a column and each column becomes a row.
(define (transpose matrix)
  ; build the matrix with tail acc
  ; recurse through each row of the matrix
  (let ((normalized (normalize-matrix matrix)))
    (define (iter m acc)
      (cond [(null? m) (reverse acc)]
            [(null? (car m)) (reverse acc)]
            [else (iter (map cdr m) (cons (map car m) acc) ) ])
      )
    
    (iter normalized '())    
    )  
  )
(transpose '())
;(transpose '((65 49)))