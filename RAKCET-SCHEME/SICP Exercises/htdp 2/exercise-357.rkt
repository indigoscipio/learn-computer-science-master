;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-357) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
; A BSL-var-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-var-expr BSL-var-expr)
; – (make-mul BSL-var-expr BSL-var-expr)

(define-struct add [left right])
(define-struct mul [left right])

;Exercise 352. Design subst.
;The function consumes a BSL-var-expr ex, a Symbol x, and a Number v.
;It produces a BSL-var-expr like ex with all occurrences of x replaced by v.

; BSL-var-expr Symbol Number -> BSL-var-expr
(define (subst ex x v)
  (cond [(number? ex) ex] ; if it's a number, return as it is
        [(and (symbol? ex) (equal? ex x)) v ] ; if x is a symbol/var, check if it matches x and repalce
        [(add? ex) (make-add (subst (add-left ex) x v)
                             (subst (add-right ex) x v))]; else find occurence of symbols and replace with number v
        [(mul? ex) (make-mul (subst (mul-left ex) x v)
                             (subst (mul-right ex) x v))]
        [else ex]

        )
  )
;(subst 'x 'x 5) ; should return 3
;(subst (make-add 3 'x) 'x 5) ; should return (make-add 3 5)
;(subst (make-mul 3 'x) 'x 5) ; should return (make-mul 3 5)


;Exercise 353. Design the numeric? function.
;It determines whether a BSL-var-expr is also a BSL-expr.
;Here we assume that your solution to exercise 345 is the definition for BSL-var-expr without Symbols.
;BSL-var-expr -> Boolean
(define (numeric? bsl-var-expr)
  (cond [(number? bsl-var-expr) #t] ;#t if all parts of an expression are numbers or valid expressions with no symbol
        [(symbol? bsl-var-expr) #f]
        [(add? bsl-var-expr) (and (numeric? (add-left bsl-var-expr))
                                 (numeric? (add-right bsl-var-expr))) ] ;#f if any part contains symbol)
        [(mul? bsl-var-expr) (and (numeric? (mul-left bsl-var-expr))
                                 (numeric? (mul-right bsl-var-expr))) ]
        [else #f]
  ))
;(check-expect (numeric? 3) #t)
;(check-expect (numeric? 'x) #f)
;(check-expect (numeric? (make-add 3 5)) #t)
;(check-expect (numeric? (make-mul 2 4)) #t)
;(check-expect (numeric? (make-mul 'x 3)) #f)
;(check-expect (numeric? (make-add (make-mul 'x 5) 4)) #f)

;Exercise 354. Design eval-variable.
;The checked function consumes a BSL-var-expr and
;determines its value if numeric? yields true for the input.
;Otherwise it signals an error.
(define (eval-variable bsl-var-expr)
  (cond [(number? bsl-var-expr) bsl-var-expr] 
        [(add? bsl-var-expr) (+ (eval-variable (add-left bsl-var-expr))
                                (eval-variable (add-right bsl-var-expr)))]
        [(mul? bsl-var-expr) (* (eval-variable (mul-left bsl-var-expr))
                                (eval-variable (mul-right bsl-var-expr)))]
        [else (error "NOT NUMERIC")]))
;(eval-variable (make-add 3 5))

; An AL (short for association list) is [List-of Association].
; An Association is a list of two items:
;   (cons Symbol (cons Number '())).
; BSL-var-expr AL -> BSL-var-expr or ERROR
(define (eval-variable* ex da)
  (cond [(empty? da) (eval-variable ex)]
        [else (eval-variable*  (subst ex (first (first da)) (second (first da)))
                               (rest da))  ])
  )
;(eval-variable* (make-add 'x (make-mul 'y 2)) '((x 3) (y 4)))



;Exercise 356. Extend the data representation of Interpreting Variables
;to include the application of a programmer-defined function.
;Recall that a function application consists of two pieces: a name and an expression.
;The former is the name of the function that is applied; the latter is the argument.
;Represent these expressions: (k (+ 1 1)), (* 5 (k (+ 1 1))), (* (i 5) (k (+ 1 1)))
;We refer to this newly defined class of data as BSL-fun-expr.

(define-struct fun-call [name arg])

;BSL-fun-expr is a
; Number
; Symbol
; (make-add BSL-fun-expr BSL-fun-expr)
; (make-fun-call Symbol BSL-fun-expr)

; (k (+ 1 1))
(define ex1 (make-fun-call 'k (make-add 1 1)))

; (* 5 (k (+ 1 1)))
(define ex2 (make-mul 5 (make-fun-call 'k (make-add 1 1))))

; (* (i 5) (k (+ 1 1)))
(define ex3 (make-mul (make-fun-call 'i 5) (make-fun-call 'k (make-add 1 1))))


;Exercise 357. Design eval-definition1. The function consumes four arguments:
;a BSL-fun-expr ex
;a symbol f, which represents a function name
;a symbol x, which represents the functions’ parameter; and
;a BSL-fun-expr b, which represents the function’s body.
;It determines the value of ex. When eval-definition1 encounters an application of f to some argument, it
;evaluates the argument,substitutes the value of the argument for x in b;
;and finally evaluates the resulting expression with eval-definition1.
(define (eval-definition1 ex f x b)
  (cond [(number? ex) ex ] ; if its a number, its already evaluated and return it
        [(symbol? ex) (error "Variable not defined")]
        [(add? ex) (+ (eval-definition1 (add-left ex) f x b)
                      (eval-definition1 (add-right ex) f x b))]
        [(mul? ex) (* (eval-definition1 (mul-left ex) f x b)
                      (eval-definition1 (mul-right ex) f x b))]
        [(fun-call? ex) ( if (equal? (fun-call-name ex) f)
                             (eval-definition1 (subst b x (eval-definition1 (fun-call-arg ex) f x b)) f x b)
                             (error "Unknown function")) ]
        )
  )

; a BSL-fun-def is a struct
; function's name (Symbol)
; functions parameter (Symbol)
; function body (BSL-fun-expression)
; make-bsl-fun-def Symbol Symbol BSL-fun-expression
(define-struct bsl-fun-def [name param body]) 

(define fun-def-ex1 (make-bsl-fun-def 'f 'x (make-add 3 'x)))
(define fun-def-ex2 (make-bsl-fun-def 'g 'y (make-mul 2 'y)) )
(define fun-def-ex3 (make-bsl-fun-def 'h 'v (make-add (make-fun-call 'f 'v) (make-fun-call 'g 'v) )))

(define da-fgh (list fun-def-ex1 fun-def-ex2 fun-def-ex3))

; BSL-fun-def* Symbol -> BSL-fun-def
; retrieves the definition of f in da
; signals an error if there is none
(define (lookup-def da f)
  (cond [(empty? da) (error "Cannot be empty!")]
        [(equal? (bsl-fun-def-name (first da)) f) (first da)]
        [else (lookup-def (rest da) f)])
  )


; BSL-fun-expr [List-of-BSL-fun-defs] -> BSL-fun-expr
; Evaluates ex using the function definitions in da.

(define (eval-function* ex da)
  (cond [(number? ex) ex]
        [(symbol? ex) (error "Cannot be a variable/symbol")]
        [(add? ex) (+ (eval-function* (add-left ex) da)
                      (eval-function* (add-right ex) da))]
        [(mul? ex) (* (eval-function* (mul-left ex) da)
                      (eval-function* (mul-right ex) da))]
        [(fun-call? ex)
         (eval-function* 
          (subst (bsl-fun-def-body (lookup-def da (fun-call-name ex)))  ; Get function body
                 (bsl-fun-def-param (lookup-def da (fun-call-name ex)))  ; Get function parameter
                 (eval-function* (fun-call-arg ex) da))  ; Replace parameter with evaluated argument
          da)]
        )
  )

(eval-function* (make-fun-call 'f 5) da-fgh)  ; Expected: 8

