;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-152) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define SQUARE (square 20 "outline" "black"))
(define EMPTY-SQUARE (square 0 "outline" "black"))
(define EMPTY-SCENE (empty-scene 0 0))

;(above SQUARE EMPTY-SQUARE)




; N Image -> Image
;col consumes a natural number n and an image img
;it produces a column (vertical arrangement) of n copies of img

(define (col n img)
  ; base case - if n is 0, return just 1 image
  ; if it reaches n or more than n, stop
  (cond [(zero? n) empty-image]
        [else (above (col (sub1 n) img ) img )]
                  )
  ;
  )


(col 5 SQUARE)


;row consumes a natural number N and an image img
;it produces a row (horizontal arrangement) of n copies of img
(define (row n img)
  (cond [(zero? n) empty-image]
        [else (beside (row (sub1 n) img ) img )]
                  )
  ;
  )
(row 9 SQUARE)