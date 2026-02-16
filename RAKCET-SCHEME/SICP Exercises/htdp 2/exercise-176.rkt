;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-176) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Matrix -> Matrix
; transposes the given matrix along the diagonal 
(define wor1 (cons 11 (cons 21 '())))
(define wor2 (cons 12 (cons 22 '())))
(define tam1 (cons wor1 (cons wor2 '())))

(define row1 (cons 11 (cons 12 '())))
(define row2 (cons 21 (cons 22 '())))
(define mat1 (cons row1 (cons row2 '())))
;(check-expect (transpose mat1) tam1)

; A Matrix is one of: 
;  – (cons Row '())
;  – (cons Row Matrix)
; constraint all rows in matrix are of the same length
 
; A Row is one of: 
;  – '() 
;  – (cons Number Row)


; function first* takes a matrix 
;and return a list of the first element for each row
; Matrix -> List-of-number
(define (first* mat)
  (cond [(empty? mat) '()]
        [else (cons (first (first mat)) (first* (rest mat))) ])
  )
;(first* tam1)


;function rest* takes a matrix
; remove its first element from each row
; and return the remaining rows (removes first column from the matrix, leaving the remaining oclumn)
; Matrix (List-of-rows) -> Matrix (List-of-rows)

(define (rest* mat)
  (cond [(empty? mat) '()]
        [else (cons (rest (first mat)) (rest* (rest mat)) ) ]
        )
  )
(rest* tam1) 
(check-expect (rest* tam1) (cons (cons 21 '()) (cons (cons 22 '()) '())) )


(define (transpose lln)
  (cond
    [(empty? (first lln)) '()]
    [else (cons (first* lln) (transpose (rest* lln)))]))
(transpose mat1)
