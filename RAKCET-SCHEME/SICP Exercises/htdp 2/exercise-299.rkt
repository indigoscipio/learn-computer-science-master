;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-299) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
;Design a data representation for finite and infinite sets so that you can represent the sets of all odd numbers,
;all even numbers, all numbers divisible by 10, and so on.

; a Finite set


; an Infinite set is a list of item with infinite quantity
; (list X1 X2 X3 ... Xinfinity )


; Design the functions add-element, which adds an element to a set;
; union, which combines the elements of two sets;
; and intersect, which collects all elements common to two sets.

; add-element is a function that adds an element x to set l
; X List-of-X -> [List-of-X]
(define (add-element x l)
  ...
  )

