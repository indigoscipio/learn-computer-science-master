;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-52-samplec) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Constants
(define WORLD-WIDTH 250)
(define WORLD-HEIGHT 100)
(define ROCKET-HEIGHT 30)
(define ROCKET-WIDTH 10)
(define GROUND-POINT (- WORLD-HEIGHT ROCKET-HEIGHT))
(define BACKGROUND (rectangle WORLD-WIDTH WORLD-HEIGHT "outline" "black"))
(define ROCKET (rectangle ROCKET-WIDTH ROCKET-HEIGHT "solid" "red"))

; Data Definition
; An LR (launching rocket) is one of:
; - "resting" (rocket is on the ground)
; - NonnegativeNumber (rocket is in the air, height above ground)

; render : LR -> Image
; Renders the rocket at the appropriate height.
(define (render ws)
  (cond
    [(equal? ws "resting") 
     (place-image ROCKET (/ WORLD-WIDTH 2) GROUND-POINT BACKGROUND)]
    [(number? ws) 
     (place-image ROCKET (/ WORLD-WIDTH 2) ws BACKGROUND)]))

; tock : LR -> LR
; Updates the rocket's position each tick (if in flight).
(define (tock ws)
  (cond
    [(equal? ws "resting") ws] ; Stay at rest
    [(<= ws 0) "resting"]        ; Stop if rocket reaches top
    [else (- ws 3)]))            ; Decrement height by 3 pixels

; change : LR KeyEvent -> LR
; Launches the rocket when space is pressed.
(define (change ws ke)
  (cond
    [(key=? ke " ") GROUND-POINT] ; Start rocket at initial height
    [else ws]))                   ; Otherwise, no change

; Launch the rocket
(define (launch-rocket ws)
  (big-bang ws
            [on-tick tock]
            [to-draw render]
            [on-key change]))

; Start the program with the rocket at rest
(launch-rocket "resting")
