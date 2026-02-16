;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-52-sampleb) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A WorldState is a Number.
; interpretation number of pixels between the top and the UFO
 
(define WIDTH 300) ; distances in terms of pixels 
(define HEIGHT 100)
(define CLOSE (/ HEIGHT 3))
(define MTSCN (empty-scene WIDTH HEIGHT)) ; short for empty scene


(define UFO (overlay/align "middle" "bottom"
     
             (rectangle 50 10 "solid" "black")
             (circle 10 "solid" "green")
             
             ))

(define (render y)
  (place-image UFO(/ WIDTH 2) y MTSCN)
  )

; WorldState -> WorldState
(define (main y0)
  (big-bang y0
     [on-tick nxt]
     [to-draw render/status]))
 
; WorldState -> WorldState
; computes next location of UFO 
(define (nxt y)
  (if (>= y (- HEIGHT 10)) ; Limit descent to bottom of canvas
      y
      (+ y 3))) ; Move 3 pixels down per tick
 
(define (render/status y)
  (cond
    [(<= 0 y CLOSE)
     (place-image (text "descending" 11 "green")
                  50 10
                  (render y))]
    [(and (< CLOSE y) (<= y HEIGHT))
     (place-image (text "closing in" 11 "orange")
                  50 10
                  (render y))]
    [(> y HEIGHT)
     (place-image (text "landed" 11 "red")
                  50 10
                  (render y))]))

(render/status 5)