#lang plai-typed

; ====================================
; TYPES

; lets keep it ArithC for now
(define-type ArithC
  [numC (n : number)]
  [plusC (l : ArithC) (r : ArithC)]
  [multC (l : ArithC) (r : ArithC)]
  [ifC (test : ArithC) (then : ArithC) (else : ArithC)]
  )

(define-type ArithS
  [numS (n : number)]
  [plusS (l : ArithS) (r : ArithS)]
  [bminusS (l : ArithS) (r : ArithS)]
  [multS (l : ArithS) (r : ArithS)]
  [uminusS (e : ArithS)]
  )

; ====================================
; DESUGAR
; when you desugar something, you turn arithS into arithC.
(define (desugar [as : ArithS]) : ArithC
  (type-case ArithS as
    [numS (n) (numC n)]
    [plusS (l r) (plusC (desugar l) (desugar r))]
    [bminusS (l r) (plusC (desugar l) (multC (desugar r) (numC -1)) )]
    [multS (l r) (multC (desugar l) (desugar r))]
    [uminusS (e) (desugar (bminusS (numS 0) e)) ]
    )
  )
(desugar (numS 5))
(desugar (plusS (numS 3) (numS 8)))
(desugar (uminusS (numS 5)))

; ====================================
; THE PARSER

(define (parse [s : s-expression]) : ArithC
  (cond [(s-exp-number? s) (numC (s-exp->number s))]
        [(s-exp-list? s) (let* ((ls (s-exp->list s))
                                (fst (s-exp->symbol (first ls))))
                           (case fst
                             [(+) (plusC (parse (second ls)) (parse (third ls)))]
                             [(*) (multC (parse (second ls)) (parse (third ls)))]
                             [else (error 'parse "invalid list")])
                           
                           )]
        [else (error 'parse "not a valid input")]
        )
  )
;(parse '5)
;(parse '(+ 1 2))
;(parse '(+ (* 2 3) 5))
;(parse '(+ (* 1 2) (+ 2 3)))

; ====================================
; THE INTERPRETER
(define (interp [a : ArithC]) : number
  (type-case ArithC a
    [numC (n) n]
    [plusC (l r) (+ (interp l) (interp r))]
    [multC (l r) (* (interp l) (interp r))]
    )
  )
;(interp (numC 8))
;(interp (plusC (numC 1) (numC 3)))

#|
DESUGARING

negation in terms of addition
a - b = a + (-1 . b)
|#