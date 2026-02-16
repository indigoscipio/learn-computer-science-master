;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-79) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Color is one of: 
; — "white"
; — "yellow"
; — "orange"
; — "green"
; — "red"
; — "blue"
; — "black"

(define color1 "white")
(define color2 "yellow")
(define color3 "black")


; H is a Number between 0 and 100.
; interpretation represents a happiness value
(define h-min 0)
(define h-low 25)
(define h-medium 50)
(define h-high 75)
(define h-max 100)


(define-struct person [fstname lstname male?])
; A Person is a structure:
;   (make-person String String Boolean)

; A Weapon is one of: 
; — #false
; — Posn
; interpretation #false means the missile hasn't 
; been fired yet; a Posn means it is in flight
(define weapon1 (make-posn 22 25))
(define weapon2 #false)