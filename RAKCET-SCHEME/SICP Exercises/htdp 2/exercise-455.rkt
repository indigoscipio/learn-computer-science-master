;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-455) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define EPSILON 0.0001)

(define (my-square x)
  (* x x)
  ) 

; [Number -> Number] Number -> Number
; takes a function f and nummber r1 (the point at which we want to compute the slope)
; returns the approximate slope of f at r1
(define (slope f r1)
  (/ (- (f (+ r1 EPSILON)) (f (- r1  EPSILON))) (* EPSILON 2))
  )
(slope my-square 4)


; [Number -> Number] Number -> Number
(define (root-of-tangent f r1)
  (- r1  (/ (f r1) (slope f r1)))
  )
(root-of-tangent my-square 4)