;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-349) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))


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