;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-159) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define SQUARE (square 20 "outline" "black"))
(define SCENE (empty-scene 500 500))
(define BALLOON (circle 5 "solid" "red") )
(define COLUMN 10)
(define ROW 20)


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


(define BASE-GRID (make-grid ROW COLUMN) )


;function add-balloons consumes a list of posns whose coordinates fit into the dimensions of the lecture hall
;it produces an image of the lecture hall with red dots added as specified by the posns.
; List-of-posns -> Image
(define (add-balloons lopsn)
  ;if the list is empty, return an empty image
  (cond [(empty? lopsn) BASE-GRID ]
        ;otherwise, recurse
        [(cons? lopsn) (place-image BALLOON (posn-x (first lopsn)) (posn-y (first lopsn)) (add-balloons (rest lopsn))) ]
        ) 
 
  )

(define-struct pair [balloon# lob])
; A Pair is a structure (make-pair N List-of-posns)
; A List-of-posns is one of: 
; – '()
; – (cons Posn List-of-posns)
; interpretation (make-pair n lob) means n balloons 
; must yet be thrown and added to lob
(define sample-pair (make-pair 5 (cons (make-posn 20 20) (cons (make-posn 40 40) '())) ))
(define sample-pair2 (make-pair 10 '()))



; RiotState -> RiotState
; Drops one baloons every 1 tick and produces a list of posns wher ethe baloons hit
(define (tock rs)
  ; check if the list of baloons is empty, if so return 
  (cond [(zero? (pair-balloon# rs)) rs]
        ;else decrement num of baloon by 1 and log a randomized posn into pair-lob
        [else (make-pair
               (sub1 (pair-balloon# rs)) 
               ;log randomizmed posn and recurse
               (cons (make-posn (* (random COLUMN) (image-width SQUARE)) (* (random ROW) (image-height SQUARE)) )
                     (pair-lob rs))
               )]
        )
  )


(define (render rs)
  (add-balloons (pair-lob rs))
  )
(render sample-pair)


; RiotState takes a Pair and returns a WorldState
; It consumes how many baloons the students want to throw
; It shows one baloon dropping after another at a rate of one per second, products list of posns where the baloons hit
(define (riot rs)
  (big-bang rs
    [on-tick tock 1]
    [to-draw render]))
(riot sample-pair2)