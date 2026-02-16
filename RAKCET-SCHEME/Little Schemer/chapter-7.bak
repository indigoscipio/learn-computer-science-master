#lang racket

; An arithmetic expression is either:
; An Atom
; Two arithmetic expressions combined by +, x, or exp

; determines wheter a representation of an arithmetic expression contains
; only nnumbers besides the +,x, and expt


; List-of-S-Expression -> Boolean
(define (numbered? aexp)

  (cond [(not(pair? aexp)) (number? aexp)] ;is an aotm
        [else (and (numbered? (car aexp)) (numbered? (caddr aexp)))] ;is a list
        )
  
  )
;(numbered? 1)
;(numbered? '(3 + (4 * 5)))
;(numbered? '(2 * sausage))

#|
; S-Expresion -> Number
; returns natural value of a nubered arithmetic expression
(define (value nexp)
  (cond [(not(pair? nexp)) nexp] ;it is an atom
        [(eq? (car (cdr nexp)) '+) (+ (value (car nexp)) (value (caddr nexp)))]
        [(eq? (car (cdr nexp)) '*) (* (value (car nexp)) (value (caddr nexp)))]
        [else (value (cdr nexp))]
        )
  )
(value '(1 + (3 + 4)))
(value 'cookie)
(value '(1 + 3))
(value '(1 + (3 * 4)))
|#

; =============================

; Recur on the subparts that are of the smae nature
; on the sublists of a list
; on the subepressions of an arithmetic expression.



; S-Expresion -> Number
; returns natural value of a nubered arithmetic expression
(define (value nexp)
  (cond [(not(pair? nexp)) nexp] ;it is an atom
        [(eq? (car nexp) '+) (+ (value (car (cdr nexp))) (value (caddr nexp)))]
        [(eq? (car nexp) '*) (* (value (car (cdr nexp))) (value (caddr nexp)))]
        ;[else (value (cdr nexp))]
        )
  )
;(value '(+ 1 (+ 3 4)))
;;(value 'cookie)
;(value '(+ 1 3))
;(value '(+ 1 (* 3 4)))


; The Eighth Commandment
; Use help functions to abstract from representations
(define (is-zero? n)
  (empty? n)
  )
(is-zero? '())

; A function that's like add1
; Number -> Number
(define (my-add1 n)
      (cons '() n)
      )
;(my-add1 '())

; A function that's like sub1
; Number -> Number
(define (my-sub1 n)
      (cdr n)
      )

; List-of-S-Expression List-of-S-Expression -> List-of-S-Expression
; builds list and recur through a and add add one '() to b on each iteration
(define (my-plus a b)
  (cond [(is-zero? a) b]
        [else (my-plus (my-sub1 a) (my-add1 b))])
  )
(my-plus '(()) '(() ()))