;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-279) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
;Exercise 279. Decide which of the followin
;phrases are legal lambda expressions:
;Explain why they are legal or illegal.
;If in doubt, experiment in the interactions area of DrRacket.

(lambda (x y) (x y y))
; this is not a legal lamda expression since the function body is not valid.
; If it was (+ x y y) then it is considered valid

(lambda () 10)
; this is not a legal lambda expression since it accepts no argument but returns 10 as the function body/expression


(lambda (x) x)
; this is a legal lambda expression since it takes argument x and returnts back the argument x

(lambda (x y) x)
; yes this is legal lambda expression it takes 2 argument x y and only returns the x so a bit unecesarry

;(lambda x 10)
; this is not a valid lambda expression since the x is not enclodes in paretnesis, and it is not treated as an argument.