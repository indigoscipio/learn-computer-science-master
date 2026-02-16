;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-94) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define WORLD-WIDTH 200)
(define WORLD-HEIGHT 300)
(define UFO-SIZE 15)
(define TANK-WIDTH 30)
(define TANK-HEIGHT 10)
(define MISSLE-WIDTH 5)
(define MISSLE-HEIGHT 10)
(define SCENE (rectangle WORLD-WIDTH WORLD-HEIGHT "outline" "black"))
(define UFO (triangle UFO-SIZE "solid" "red"))
(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" "green"))
(define MISSLE (rectangle MISSLE-WIDTH MISSLE-HEIGHT "solid" "black"))



; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)

; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick
(define-struct tank [loc vel])
(define tank-sample (make-tank 25 3))

; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place


(define-struct aim [ufo tank] )
(define-struct fired [ufo tank missle])



; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game

(define (render si)
  (cond [(aim? si) (place-image TANK (tank-loc(aim-tank si)) (- WORLD-HEIGHT (/ TANK-HEIGHT 2)) (place-image UFO (posn-x (aim-ufo si)) (posn-y (aim-ufo si)) SCENE))]
        [(fired? si) (place-image TANK (tank-loc(fired-tank si)) (- WORLD-HEIGHT (/ TANK-HEIGHT 2)) (place-image UFO (posn-x (fired-ufo si)) (posn-y (fired-ufo si)) (place-image MISSLE (posn-x (fired-missle si)) (posn-y (fired-missle si)) SCENE))) ]
        )
  )

(render (make-aim (make-posn 100 50) (make-tank 20 -3)))
(render (make-fired (make-posn 100 50) (make-tank 20 -3) (make-posn 0 33)))



