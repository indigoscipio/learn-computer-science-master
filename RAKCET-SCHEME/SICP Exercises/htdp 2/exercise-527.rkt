;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-527) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define UNIT-SIZE 16)
(define LINE-COLOR "black")
(define TRIANGLE-IMG (triangle UNIT-SIZE "outline" "black"))
(define BG (empty-scene 400 400) )
(define SIZE-THRESHOLD 10)
(define A (make-posn 200  50))
(define B (make-posn  27 350))
(define C (make-posn 373 350))


; Image Posn Posn Posn -> Image 
; adds the black triangle a, b, c to scene
(define (add-triangle scene a b c)
  (scene+line
   (scene+line
    (scene+line scene (posn-x a) (posn-y a) (posn-x b) (posn-y b) LINE-COLOR )
    (posn-x b) (posn-y b) (posn-x c) (posn-y c) LINE-COLOR )
   (posn-x c) (posn-y c) (posn-x a) (posn-y a) LINE-COLOR )
  )

(add-triangle BG (make-posn 5 10) (make-posn 10 20) (make-posn 50 50))

; Posn Posn -> Number
; calculates eucliden bettween points a and b
(define (distance a b)
  (sqrt (+ (expt (- (posn-x a) (posn-x b)) 2) (expt (- (posn-y a) (posn-y b)) 2) )  )
  )


; Posn Posn Posn -> Boolean 
; is the triangle a, b, c too small to be divided
(define (too-small? a b c)
  (or (<= (distance a b) SIZE-THRESHOLD)
      (<= (distance b c) SIZE-THRESHOLD)
      (<= (distance c a) SIZE-THRESHOLD)
       )
  )
(too-small? (make-posn 0 0) (make-posn 5 0) (make-posn 0 5))
(too-small? (make-posn 0 0) (make-posn 20 0) (make-posn 0 20))


; Posn Posn -> Posn 
; determines the midpoint between a and b
(define (mid-point a b)
  (make-posn 
   (/ (+ (posn-x a) (posn-x b)) 2)
   (/ (+ (posn-y a) (posn-y b)) 2))
  )
(mid-point (make-posn 1 1) (make-posn 12 12))


; Image Posn Posn Posn -> Image 
; generative adds the triangle (a, b, c) to scene0, 
; subdivides it into three triangles by taking the 
; midpoints of its sides; stop if (a, b, c) is too small
; accumulator the function accumulates the triangles of scene0
(define (add-sierpinski scene0 a b c)
  (cond
    [(too-small? a b c) scene0]
    [else
     (local
       ((define scene1 (add-triangle scene0 a b c))
        (define mid-a-b (mid-point a b))
        (define mid-b-c (mid-point b c))
        (define mid-c-a (mid-point c a))
        (define scene2
          (add-sierpinski scene1 a mid-a-b mid-c-a))
        (define scene3
          (add-sierpinski scene2 b mid-b-c mid-a-b)))
       ; —IN—
       (add-sierpinski scene3 c mid-c-a mid-b-c))]))
(add-sierpinski BG A B C)
