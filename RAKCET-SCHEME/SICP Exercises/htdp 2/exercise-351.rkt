;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-351) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))


(define-struct add [left right])
(define-struct mul [left right])
(define WRONG "ERROR!")

(define (atom? x)
  (or (string? x) (number? x) (symbol? x))
  )


; S-expr -> BSL-expr
(define (parse s)
  (cond
    [(atom? s) (parse-atom s)]
    [else (parse-sl s)]))
 
; SL -> BSL-expr 
(define (parse-sl s)
  (cond
    [(and (consists-of-3 s) (symbol? (first s)))
     (cond
       [(symbol=? (first s) '+)
        (make-add (parse (second s)) (parse (third s)))]
       [(symbol=? (first s) '*)
        (make-mul (parse (second s)) (parse (third s)))]
       [else (error WRONG)])]
    [else (error WRONG)]))
 
; Atom -> BSL-expr 
(define (parse-atom s)
  (cond
    [(number? s) s]
    [(string? s) (error WRONG)]
    [(symbol? s) (error WRONG)]))
 
; SL -> Boolean
(define (consists-of-3 s)
  (and (cons? s) (cons? (rest s)) (cons? (rest (rest s)))
       (empty? (rest (rest (rest s))))))


;Exercise 349. Create tests for parse until DrRacket tells you that every element
;in the definitions area is covered during the test run.

; Tests for parse
(check-expect (parse '(+ 3 3)) (make-add 3 3))
(check-expect (parse '(* 3 3)) (make-mul 3 3))
(check-error (parse '(3 3)) WRONG)  ; Invalid expression
(check-error (parse '(+ 3)) WRONG)   ; Not enough arguments
(check-error (parse '(* "hello" 3)) WRONG) ; Invalid operand (string)
(check-error (parse '(+ #true #false)) WRONG) ; Invalid operands (booleans)
(check-error (parse '(unknown 3 3)) WRONG) ; Unknown operator

(define (interpreter-expr s-expr)
  (eval-expression (parse s-expr)))

;; Helper function to evaluate parsed expressions
(define (eval-expression bsl-expr-rep)
  (cond 
    [(number? bsl-expr-rep) bsl-expr-rep]  ; Base case: A number evaluates to itself
    [(add? bsl-expr-rep) 
     (+ (eval-expression (add-left bsl-expr-rep)) 
        (eval-expression (add-right bsl-expr-rep)))]
    [(mul? bsl-expr-rep) 
     (* (eval-expression (mul-left bsl-expr-rep)) 
        (eval-expression (mul-right bsl-expr-rep)))]
    [else (error "Invalid expression!")]))  ; Shouldn't happen if parse works correctly

;; Tests
(check-expect (interpreter-expr '(+ 1 2)) 3)
(check-expect (interpreter-expr '(* 3 4)) 12)
(check-expect (interpreter-expr '(+ (* 2 3) 4)) 10)
(check-error (interpreter-expr '("hello")) "ERROR!")  ; Invalid case
