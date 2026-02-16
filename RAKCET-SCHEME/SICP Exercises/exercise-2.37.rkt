#lang racket

;exercise 2.33


(define (accumulate op initial sequence)
  (define (accumulate-helper sequence acc)
    (if (null? sequence)
        acc
        (accumulate-helper (cdr sequence) (op (car sequence) acc))))
  (accumulate-helper sequence initial))


;fill in missing expression of some basic list-manipulation operation as accumulations
;(define (map p sequence)
;  (accumulate (lambda (x y) ⟨??⟩) nil sequence))
;(define (map p sequence)
;  (accumulate (lambda (x y) (cons (p x) y) ) '() sequence))
;(map sqr '(1 2 3))

;(define (append seq1 seq2)
; (accumulate cons (???) (???) ))
(define (append seq1 seq2)
  (accumulate cons seq2 (accumulate cons '() seq1))
  )

;(define (length sequence)
;  (accumulate <???> 0 sequence))
;(define (length sequence)
;  (accumulate (lambda (item acc) (+ 1 acc) ) 0 sequence)
;  )

; Exercise 2.4

; Number List-of-Number -> Number
(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) (+ (* higher-terms x) this-coeff) ) 0 coefficient-sequence)
  )
;(horner-eval 2 (list 1 3 0 5 0 1))

;exercise 2.35
; redefine count-leaves from section 2.2.2 as an accumulation
; A Tree is either of the following:
; A Number
; A List-of-Tree

; Tree -> Number
(define (count-leaves-old x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves-old (car x))
                 (count-leaves-old (cdr x))))))

; List-of-[List-of-X] -> List-of-X
(define (enumerate-leaves t)
  (cond [(empty? t) '()]
        [(not (pair? t)) (list t) ]
        [else (append (enumerate-leaves (car t)) (enumerate-leaves (cdr t)) ) ]
        )
  )
;(enumerate-leaves '(1 2 3 (4 6 7) 5))

; Tree -> Number
(define (count-leaves t)
  (accumulate + 0 (map (lambda (subtree) (cond [(not(pair? subtree)) 1]
                                               [else (count-leaves subtree)]) ) t) )
  )
;(count-leaves '(1 (2 (3 4)) 5))

; [X -> Y] List-of-Y List-of-[List-of-X] -> List-of-Y
; computes the nth item in a list of lists and sums them together
(define (accumulate-n op init seqs)
  (cond [(empty? (car seqs)) '()]
        [else 
         (cons (accumulate op init (map (lambda (seq) (first seq) ) seqs) )
               (accumulate-n op init (map rest seqs))
               )
         ])
  )
;(define list2 '( (1 2 3) (4 5 6) (5 6 7) ))
;(map rest list2)
;(accumulate-n + 0 '( (1 2 3) (4 5 6) (7 8 9) (10 11 12) )) ; should return (22 26 30)

;exercise 2.37
; Vector v = (Vi) -> list of numbers -> '(1 2 3 4)
; Matrix m = (Mij) -> list of vectors (rows of the matrix)

(define matrix0 '((1 2 3) (4 5 6) (7 8 9)))
(define vector0 '(1 2 3))

; Vector Vector -> Number
; computes the sum of two vectors
(define (dot-product v w)
  (accumulate + 0 (map * v w) )
  )
;(dot-product '(1 2 3) '(1 2 3))

; Matrix Vector -> Vector
; computes new vector by multiplying matrix m with vector v
(define (matrix-*-vector m v)
  (map (lambda (row) (dot-product row v) ) m)
  )
;(matrix-*-vector matrix0 vector0)

; Matrix -> Matrix
; transposes matrix M
(define (transpose m)
  (accumulate-n cons '()  (reverse m))
  )
;(transpose matrix0)


;Matrix Matrix ->
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    ; Matrix Matrix -> ???
    (map (lambda (row)
           (map (lambda (col)
                  (dot-product row col) ) cols) ) m)
    )
  )
;(matrix-*-matrix '((1 2 3) (4 5 6)) '((1 2)(3 4)(5 6)))

;exercise-2.38
; fold left, combines all elements to the left
(define (fold-left op initial sequence)
  (define (iter l0 acc)
    (cond [(empty? l0) acc]
          [else (iter (cdr l0) (op acc (car l0)))])
    )
  (iter sequence initial)
  )

;combines all elements to the right
(define (fold-right op initial sequence)
  (define (iter l0 acc)
    (cond [(empty? l0) acc]
          [else (iter (cdr l0) (op (car l0) acc))])
    )
  (iter sequence initial)
  )

(fold-right / 1 '(1 2 3)) ; returns 1 1/2
; 1st call: iter '(1 2 3) 1
; l0 = '(1 2 3), acc = 1
; l0 is not empty -> go to (iter '(2 3) (/ 1 1) )
; l0 = '(2 3), acc = 1 / 1 = 1
; l0 is not empty -> go to (iter '(3)) (/ 2 1)
; l0 = '(3), acc = 2 / 1 = 2
; l0 is not empty -> go to (iter '()) (/ 3 2)
; l0 = '(), acc = 3 / 2 = 1 1/2
; l0 is empty, return 1 1/2

(fold-left / 1 '(1 2 3)) ; returns 1/6
; 1st call: iter '(1 2 3) 1
; l0 = '(1 2 3), acc = 1
; l0 is not empty -> go to (iter '(2 3) (/ 1 1))
; l0 = '(2 3), acc = 1
; l0 is not empty -> go to (iter '(3) (/ 1 2 )
; l0 = '(3), acc = 0.5
; l0 is not empty -> go to (iter '() (/ 0.5 3))
; l0 = '(), acc = 0.16667
; l0 is empty, 0.16667

(fold-right list '() '(1 2 3)) ; returns '(3 (2 (1 ())))
; 1st call: iter '(1 2 3) '()
; l0 = '(1 2 3), acc = '()
; l0 is not empty -> go to (iter '(2 3) (list 1 '()) )
; l0 = '(2 3), acc = (list 1 '())
; l0 is not empty -> go to (iter '(3) (list 2 (list 1 '())) )
; l0 = '(3), acc = (list 2 (list 1 '()))
; l0 is not empty -> go to (iter '() (list 3 (list 2 (list 1 '()))) )
; l0 is empty, return (list 3 (list 2 (list 1 '())))

(fold-left list '() '(1 2 3)) ; return '(((()) 2) 3)
; 1st call: iter '(1 2 3) '()
; l0 = '(1 2 3), acc = '()
; l0 is not empty -> go to (iter '(2 3) (list '() 1))
; l0 = '(2 3), acc = (list '() 1))
; l0 is not empty -> go to (iter '(3) (list (list '() 1) 2) )
; l0 = '(3), acc = (list (list '() 1 ) 2 )
; l0 is not empty -> go to (iter '() (list (list (list '() 1 ) 2 ) 3)
(list (list (list '() 1 ) 2 ) 3)

;property that op should satisfy to guarantee that fold right and fold left
; will produce the same values for any sequnce
;(fold-left * 1 '(1 2 3)) ; returns 6
;(fold-right * 1 '(1 2 3)) ; returns 6
;(fold-left append '() '((a) (b) (c)))
;(fold-right append '() '((a) (b) (c)))