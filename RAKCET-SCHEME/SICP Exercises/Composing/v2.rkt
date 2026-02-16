;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname v2) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))




(define WIDTH 200)
(define HEIGHT 200)
(define EMPTY (empty-scene WIDTH HEIGHT))
(define BOAT
  
(overlay/offset
 
 (right-triangle 30 30 "solid" "blue")
 -10 50

 (overlay/align "middle" "bottom"
 (isosceles-triangle 50 230 "solid" "seagreen")
 (rectangle 5 75 "solid" "tan")
 
 ))
  )

(place-image
   BOAT
   50 50
   EMPTY)
