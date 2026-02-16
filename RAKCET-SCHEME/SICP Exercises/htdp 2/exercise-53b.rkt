;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-53b) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Constants
(define HEIGHT 300) ; Canvas height
(define WIDTH 100) ; Canvas width
(define YDELTA 3) ; Rocket movement per tick
(define BACKG (empty-scene WIDTH HEIGHT)) ; Background scene
(define ROCKET (rectangle 5 30 "solid" "red")) ; Rocket shape
(define CENTER (/ (image-height ROCKET) 2)) ; Center of the rocket for positioning

; Data Definition
; An LRCD (Launching Rocket Countdown Data) is one of:
; - "resting" (string): rocket is on the ground
; - Number between -3 and -1: countdown phase
; - NonnegativeNumber: height of the rocket in flight

; Function Signatures and Definitions

; show : LRCD -> Image
; Renders the current state of the rocket as an image.
(define (render-rocket rocket-y-pos)
  (place-image ROCKET 10 rocket-y-pos BACKG)
  )

(define (show x)
  (cond
    [(string? x) 
     (render-rocket (- HEIGHT CENTER))] ; Resting on the ground
    [(<= -3 x -1) 
     (place-image (text (number->string x) 20 "red") 10 (* 3/4 WIDTH)
                  (render-rocket (- HEIGHT CENTER)))] ; Countdown text
    [(>= x 0) 
     (render-rocket (- x CENTER))])) ; Rocket moving upward

; launch : LRCD KeyEvent -> LRCD
; Starts the countdown when the spacebar is pressed.
(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))



; fly : LRCD -> LRCD
; Updates the rocket's position or progresses the countdown.
(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) HEIGHT (+ x 1))]
    [(>= x 0) (- x YDELTA)]))

; Main Program
; Launches the rocket simulation.
(define (launch-rocket x)
  (big-bang x
            [on-tick fly]
            [to-draw show]
            [on-key launch]))

; Start the program with the rocket at rest.
(launch-rocket "resting")
