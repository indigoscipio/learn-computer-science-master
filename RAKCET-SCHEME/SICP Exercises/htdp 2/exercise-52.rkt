;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-52) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define BACKGROUND (rectangle  200 50 "outline" "black"))
(define WORLD-WIDTH 200)
(define WORLD-HEIGHT 50)
(define BASE-SIZE 25)

(define red-dot (circle BASE-SIZE "solid" "red"))

(define (tock ws)
  ws
  )

(define (change ws ke)
  (cond [(key=? ke "left") (- ws 10) ]
        [(key=? ke "right") (+ ws 10) ]
        [else ws])
  )

(define (render ws)
  (place-image red-dot ws (/ WORLD-HEIGHT 2) BACKGROUND )
  )

(define (red-dot-bb ws)
  (big-bang ws
  [on-tick tock 1]
  [to-draw render]
    [on-key change]
    ))

(red-dot-bb 100)