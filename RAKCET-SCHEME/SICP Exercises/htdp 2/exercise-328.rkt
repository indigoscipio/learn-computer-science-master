;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-328) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; S-expr Symbol Atom -> S-expr
; replaces all occurrences of old in sexp with new
 
(check-expect (substitute '(((world) bye) bye) 'bye '42)
              '(((world) 42) 42))

(define (atom? x)
  (or (number? x) (string? x) (symbol? x))
  )

(define (substitute sexp old new)
  (local (; S-expr -> S-expr
          (define (for-sexp sexp)
            (cond
              [(atom? sexp) (for-atom sexp)]
              [else (for-sl sexp)]))
          ; SL -> S-expr 
          (define (for-sl sl)
            (cond
              [(empty? sl) '()]
              [else (cons (for-sexp (first sl))
                          (for-sl (rest sl)))]))
          ; Atom -> S-expr
          (define (for-atom at)
            (cond
              [(number? at) at]
              [(string? at) at]
              [(symbol? at) (if (equal? at old) new at)])))
    (for-sexp sexp)))
