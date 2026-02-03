#lang plai-typed

(define-type MisspelledAnimal
[caml (humps : number)]
[yacc (height : number)])

(caml 2)
(yacc 10)

(define (get-info [a : MisspelledAnimal]) : number
  (type-case MisspelledAnimal a
    [caml (h) h]
    [yacc (ht) ht]))
(get-info (yacc 2))

(define (good? [ma : MisspelledAnimal]) : boolean
  (type-case MisspelledAnimal ma
    [caml (humps) (>= humps 2)]
    [yacc (height) (> height 2.1)]))
  
(define ma1 (caml 2))

; ====================================
; THE PARSER

(define-type ArithC
  [numC (n : number)]
  [plusC (l : ArithC) (r : ArithC)]
  [multC (l : ArithC) (r : ArithC)]
  )

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
(parse '5)
(parse '(+ 1 2))
(parse '(+ (* 2 3) 5))
(parse '(+ (* 1 2) (+ 2 3)))

; ====================================
; THE INTERPRETER
(define (interp [a : ArithC]) : number
  (type-case ArithC a
    [numC (n) n]
    [plusC (l r) (+ (interp l) (interp r))]
    [multC (l r) (* (interp l) (interp r))]
    )
  )
(interp (numC 8))
(interp (plusC (numC 1) (numC 3)))

#|
exercise
because the parse function is built to handle s-expressions. it's looking for a structure
of the code not the final result of the code
|#


#|
when we do define type, we set up 3 main things:
- type name
- the variants - what specific shape fit into this type?
- the fields - what pieces of data fit into each variants"
|#