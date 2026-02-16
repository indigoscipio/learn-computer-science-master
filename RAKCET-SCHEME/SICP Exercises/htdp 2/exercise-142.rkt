;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-142) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;ill-sized? function consumes a list of images loi and a pos number n
; it produces the first image on loi that is not an n by n square
; if it cannot find such image, it produces false.
(define img1 (square 10 "outline" "red"))
(define img2 (rectangle 20 10 "outline" "red"))
(define img3 (square 50 "outline" "red"))


; ImageOrFalse is one of:
; – Image
; – #false
(define sample-loi (cons img1 (cons img2 (cons img3 '()))))


(define (ill-sized? loi n)
  (cond [(empty? loi) #false]
        ;if theres an image that doesn't match n x n square, return that image
        [(not (and (equal? (image-width (first loi)) n) (equal? (image-height (first loi)) n) )) (first loi)]
        [else (ill-sized? (rest loi) n )]
        )
  )
(ill-sized? sample-loi 10)