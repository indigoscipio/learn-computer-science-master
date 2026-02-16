;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-104) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Vehicle: (make-vehicle Number String Number)
; num-of-passengers: non negative numbre
; license-plate: 6 word string
; fuel-consumption: miles per gallon
(define-struct automobile [num-of-passengers license-plate fuel-consumption])
(define-struct vans [num-of-passengers license-plate fuel-consumption])
(define-struct bus [num-of-passengers license-plate fuel-consumption])
(define-struct suv [num-of-passengers license-plate fuel-consumption])

(define )