;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise-252) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] -> Number
(define (product l)
  (cond
    [(empty? l) 1]
    [else
     (* (first l)
        (product
          (rest l)))]))


; [List-of Posn] -> Image
(define (image* l)
  (cond
    [(empty? l) emt]
    [else
     (place-dot
      (first l)
      (image* (rest l)))]))
 
; Posn Image -> Image 
(define (place-dot p img)
  (place-image
     dot
     (posn-x p) (posn-y p)
     img))
 
; graphical constants:    
(define emt
  (empty-scene 100 100))
(define dot
  (circle 3 "solid" "red"))
(define sample-lop (list (make-posn 10 10) (make-posn 20 20)))
(define sample-lon (list 1 2 3 4 5))

; an NP is either of the following:
; Number
; Posn
;[List-of-A] [A B -> B] B
(define (fold2 lonp f bc)
  (cond [(empty? lonp) bc]
        [else (f (first lonp) (fold2 (rest lonp) f bc)) ]
        )
  )

; [List-of-number] -> Number
(define (product-from-fold2 lon)
  (fold2 lon * 1)
  )
(product-from-fold2 sample-lon)

; [List-of-image] -> Image
(define (image*-from-fold2 loi)
  (fold2 loi place-dot emt)
  )
(image*-from-fold2 sample-lop)
