;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-40) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Constants for dimensions
(define WIDTH-OF-WORLD 200)
(define HEIGHT-OF-WORLD 50)
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
(define CAR-BODY-WIDTH (* WHEEL-RADIUS 9))
(define CAR-BODY-HEIGHT (* WHEEL-RADIUS 3))
(define CAR-Y-POS (* WHEEL-RADIUS 7))

; Scenery
(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))



; Wheel and car body definitions
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define SPACE-BETWEEN-WHEELS (rectangle WHEEL-DISTANCE 0 "solid" "white"))
(define CAR-BODY (rectangle CAR-BODY-WIDTH CAR-BODY-HEIGHT "solid" "black"))

; Wheels placed beside each other with space in between
(define WHEELS
  (beside WHEEL
          SPACE-BETWEEN-WHEELS
          WHEEL))

; Full car (car body above wheels)
(define CAR
  (above CAR-BODY WHEELS))

; Background outline
(define BACKGROUND
  (rectangle WIDTH-OF-WORLD HEIGHT-OF-WORLD "outline" "black"))

(define BACKGROUND-WITH-TREE
  (overlay/align "middle" "bottom"
   TREE
   BACKGROUND)
  )

; Render car on background
(define (render cw)
(place-image CAR cw CAR-Y-POS BACKGROUND-WITH-TREE))

(define (tock cw)
  (+ cw 3))

(define (stop cw)
  (>= cw 175)
  )

(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]
     [stop-when stop]
     ))

(main 0)