#lang plai-typed

; ====================================
; TYPES

; lets keep it ArithC for now

; ARITHS
(define-type ArithS
  [numS (n : number)]
  [plusS (l : ArithS) (r : ArithS)]
  [bminusS (l : ArithS) (r : ArithS)]
  [multS (l : ArithS) (r : ArithS)]
  [uminusS (e : ArithS)]
  )

; FUNCTIONS
; argument names must be unique withn a single fundef
(define-type FunDefC
  ; function definiton takes the name, the arg, and the body
  [fdC (name : symbol) (arg : symbol) (body : ExprC)]
  )

; EXPRESSION
; identifier is just the name
(define-type ExprC
  [numC (n : number)]
  [idC (s : symbol)]
  [plusC (l : ExprC) (r : ExprC)]
  [multC (l : ExprC) (r : ExprC)]
  [appC (fun : symbol) (arg : ExprC)]
  )
(fdC 'double 'x (plusC (idC 'x) (idC 'x)))
(fdC 'quadruple 'x (appC 'double (appC 'double (idC 'x))))
(fdC 'const5 '_ (numC 5))



; ====================================
#|
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
|#

; ====================================
; THE PARSER

#|
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
|#

; ====================================

; GET FUNDEF
; symbol (listof fundefc) -> FunDefC
(define (get-fundef [s : symbol] [fds : (listof FunDefC)]) : FunDefC
    (cond [(empty? fds) (error 'get-fundef "function definition not found")]
          [(equal? s (fdC-name (first fds))) (first fds)]
          [else (get-fundef s (rest fds))])
  )
(get-fundef 'double (list (fdC 'double 'x (plusC (idC 'x) (idC 'x)))
                          (fdC 'quadruple 'x (appC 'double (appC 'double (idC 'x))))
                          (fdC 'const5 '_ (numC 5))))

; SUBST
; ExprC symbol ExprC -> ExprC
(define (subst [what : ExprC] [for : symbol] [in : ExprC]) : ExprC
  ; number : nothing to subst
  ; identifier: unchanged
  ; recurse and substitute
  (type-case ExprC in
    [numC (n) in]
    [idC (s) (if (equal? s for)
                 what ;replace it
                 in)] 
    [appC (fun arg) (subst ) ]
    [plusC (l r) (plusC (subst what for l) (subst what for r)) ]
    [multC (l r) ]
    )
  )
(subst (numC 7) 'n (plusC (idC 'n) (multC (numC 2) (idC 'n))))

 
#|
; THE INTERPRETER
(define (interp [a : ExprC] [fds : (listof FunDefC)]) : number
  (type-case ExprC e
    [numC (n) n]
    [plusC (l r) (+ (interp l fds) (interp r fds))]
    [multC (l r) (* (interp l fds) (interp r fds))]
    )
  )
;(interp (numC 8))
;(interp (plusC (numC 1) (numC 3)))
|#


#|
DESUGARING

negation in terms of addition
a - b = a + (-1 . b)
|#