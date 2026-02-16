;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-318) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
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
;(atom? "string")

;Sample Problem Design the function count, which determines how many times
;some symbol occurs in some S-expression.
; counts all occurrences of sy in at

(define (count-main sexp sy)
  (local ( ; Atom Symbol -> N 
          ; counts all occurrences of sy in at
          (define (count-atom at)
            (cond
              [(number? at) 0]
              [(string? at) 0]
              [(symbol? at) (if (symbol=? at sy) 1 0)])) 

          ; S-expr Symbol -> N
          (define (count sexp)
            (cond [(atom? sexp) (count-atom sexp)]
                  [else (count-sl sexp) ])
            )
          ; SL Symbol -> N
          ; counts all occurrences of sy in sl
          (define (count-sl sl) 
            (cond [(empty? sl) 0]
                  [else (+ (count (first sl)) (count-sl (rest sl)) )])
            ) 
          )
    (count sexp)
    )
  )
;(check-expect (count-main 'world 'hello) 0)
;(check-expect (count-main '(world hello) 'hello) 1)
;(check-expect (count-main '(((world) hello) hello) 'hello) 2)

; SL -> Numbre
; computes maximum depth in a given sl
(define (max-depth sl)
  (cond [(empty? sl) 0]
        [else (max (depth (first sl)) (max-depth (rest sl))) ])
  )

; S-expr (Atom/SL) -> Number
;An Atom has a depth of 1. The depth of a list of S-expressions is the maximum depth of its items plus 1. 
(define (depth sexp)
  (cond 
    [(empty? sexp) 1]
    [(atom? sexp) 1]
    [else  (+ 1 (max-depth sexp)) ])
  )
;(depth '(a b c))
;(check-expect (depth 'hello) 1)
;(check-expect (depth '(a b c)) 2)

;Exercise 319. Design substitute.
;It consumes an S-expression s and two symbols, old and new.
;The result is like s with all occurrences of old replaced by new. 

; S-expr Symbol Symbol -> S-expr
(define (substitute s sy-old sy-new)
  (cond [(and (atom? s) (equal? s sy-old)) sy-new ] ;handle atom
        [(empty? s) '()]
        [(list? s) (cons (substitute (first s) sy-old sy-new)
                         (substitute (rest s) sy-old sy-new) )] ;handle list/SL
        [else s]
        )
  ) 
(check-expect (substitute 's 's 'gg) 'gg)
(check-expect (substitute '(1 8 hello) 'hello 'world) '(1 8 world)) 
(check-expect (substitute '(1 8 hello (world hello)) 'hello 'world) '(1 8 world (world world)))