;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-113) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Any -> Boolean
; is a an element of the MissileOrNot collection
(define (missile-or-not? v)
  (cond
    [(or (false? v) (posn? v)) #true]
    
    ;[(false? v) #true]
    ;[(posn? v) #true]
    
    [else #false]
    ))

(missile-or-not? (make-posn 7 8))

(missile-or-not? "FFF")

(missile-or-not? #false)

; SIGS is a structure of either
; make aim or make fired