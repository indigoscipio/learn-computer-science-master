;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-2-21) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;2.21 area of triangle
(define (f2c n)
  (* (- n 32) (/ 5 9))
  )


;2.23 calculate area of triangle
(define (triangle b h)
  (* 0.5 b h)
  )


;2.24 convert3
(define (convert3 d0 d1 d2)
  (+ (* d0  100) (* d1 10) (* d2 10))
  )