;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-432) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define MAX 50)

; ; Posn -> Posn 
; ???
;(check-satisfied (food-create (make-posn 1 1)) not=-1-1?)

(define (food-create p)
  (local ( 
          ; Posn Posn -> Posn 
          ; generative recursion 
          ; ???
          (define (food-check-create candidate)
            (if (equal? p candidate) (food-check-create p) candidate)))
    
    (food-check-create
     (make-posn (random MAX) (random MAX)))
    )
  )
(food-create (make-posn 50 50))

#|
Why is it a generative recursion function?
Because it makes a subproblem by calling food-check-create
Keeps calling until the number is not the same
Not a structural recursion like using ()(rest)
|#
 
; Posn -> Boolean
; use for testing only 
(define (not=-1-1? p)
  (not (and (= (posn-x p) 1) (= (posn-y p) 1))))
