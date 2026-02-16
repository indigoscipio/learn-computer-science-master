;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-153) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define SQUARE (square 20 "outline" "black"))
(define SCENE (empty-scene 500 500))
(define BALLOON (circle 5 "solid" "red") )


; N Image -> Image
;col consumes a natural number n and an image img
;it produces a column (vertical arrangement) of n copies of img

(define (col n img)
  (cond [(zero? n) empty-image]
        [else (above (col (sub1 n) img ) img )]
                  )
  ;
  )


(define (row n img)
  (cond [(zero? n) empty-image]
        [else (beside (row (sub1 n) img ) img )]
                  )
  ;
  )


;make grid is a function that takes row and column
;and produces a rentangle of row by columns, placed in an empty scene of the same size
; r is a posiitve integer natural number
; n is a positive integer natural number




(define (make-grid r c)
  (place-image
   (col r (row c SQUARE))                     ; Create the grid
   (/ (* (image-width SQUARE) c) 2)           ; Center horizontally
   (/ (* (image-height SQUARE) r) 2)          ; Center vertically
   (empty-scene (* (image-width SQUARE) c)    ; Empty scene of the same size
                (* (image-height SQUARE) r))))


(define BASE-GRID (make-grid 20 10) )


;function add-balloons consumes a list of posns whose coordinates fit into the dimensions of the lecture hall
;it produces an image of the lecture hall with red dots added as specified by the posns.
; List-of-posns -> Image

(define sample-posn-1 (make-posn 20 20))
(define sample-posn-2 (make-posn 40 40))
(define sample-posn-3 (make-posn 60 60))
(define sample-lopsn (cons sample-posn-1 (cons sample-posn-2 (cons sample-posn-3 '()))))

(define (add-balloons lopsn)
  ;if the list is empty, return an empty image
  (cond [(empty? lopsn) BASE-GRID ]
        ;otherwise, recurse
        [(cons? lopsn) (place-image BALLOON (posn-x (first lopsn)) (posn-y (first lopsn)) (add-balloons (rest lopsn)) ) ]
        ) 
 
  )

(add-balloons sample-lopsn)