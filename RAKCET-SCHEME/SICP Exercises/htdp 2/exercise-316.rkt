;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-316) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
;Exercise 316. Define the atom? function.

; An S-expr is one of: 
; – Atom
; – SL

; An SL is one of: 
; – '()
; – (cons S-expr SL)

; An Atom is one of: 
; – Number
; – String
; – Symbol


(define (atom? x)
  (or (number? x) (string? x) (symbol? x))
  )
(atom? "string")

;Sample Problem Design the function count, which determines how many times
;some symbol occurs in some S-expression.
; counts all occurrences of sy in at 
(define (count-atom at sy)
  (cond
    [(number? at) 0]
    [(string? at) 0]
    [(symbol? at) (if (symbol=? at sy) 1 0)]))


; S-expr Symbol -> N
(define (count sexp sy)
  (cond [(atom? sexp) (count-atom sexp sy)]
        [else (count-sl sexp sy) ])
  )

; SL Symbol -> N
; counts all occurrences of sy in sl
(define (count-sl sl sy) 
  (cond [(empty? sl) 0]
        [else (+ (count (first sl) sy) (count-sl (rest sl) sy) )])
  )

(check-expect (count 'world 'hello) 0)
(check-expect (count '(world hello) 'hello) 1)
(check-expect (count '(((world) hello) hello) 'hello) 2)



