;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-156) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define HEIGHT 220) ; distances in terms of pixels 
(define WIDTH 80)
(define XSHOTS (/ WIDTH 2) )
 
; graphical constants 
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define SHOT (triangle 10 "solid" "red"))



; A List-of-shots is one of: 
; – '()
; – (cons Shot List-of-shots)
; interpretation the collection of shots fired 


; A Shot is a Number.
; interpretation represents the shot's y-coordinate 


; A ShotWorld is List-of-numbers. 
; interpretation each number on such a list
;   represents the y-coordinate of a shot 


; ShotWorld -> Image
; adds the image of a shot for each  y on w 
; at (MID,y) to the background image 
(define (to-image w)
  (cond [(empty? w) BACKGROUND]
        [(cons? w) (place-image SHOT XSHOTS (first w) (to-image (rest w)))])
  )

;(place-image SHOT XSHOTS (- HEIGHT (image-height SHOT)) BACKGROUND)

;(to-image '())
;(to-image (cons 9 '()))
;(to-image (cons 60 (cons 20 (cons 9 '()))))

;function out-of-bound? take a number and returns a boolean
;it checks if whether a shot has reached the top of the canvas (y <= 0)
(define (out-of-bound? shot)
  (if (<= shot 50) #true #false )
  )


; ShotWorld -> ShotWorld
; moves each shot on w up by one pixel 
(define (tock w)
  (cond [(empty? w) w] ; If the list is empty, return it as is
        [(out-of-bound? (first w)) (tock (rest w))] ; Skip the out-of-bound shot
        [else (cons (sub1 (first w)) (tock (rest w)))])) ; Move the shot up and continue


;(tock '())
(tock (cons 9 '()))
(tock (cons 60 (cons 30 (cons 10 '()))))
(tock (cons 51 (cons 52 (cons 53 '()))))



; ShotWorld KeyEvent -> ShotWorld 
; adds a shot to the world 
; if the player presses the space bar
(define (keyh w ke)
  (if (key=? ke " ") (cons HEIGHT w) w))


; ShotWorld -> ShotWorld 
(define (main w0)
  (big-bang w0
    [on-tick tock]
    [on-key keyh]
    [to-draw to-image]))

;(main '())