;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-454b) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; A Row is a list of number
;(list 1 2 3 )

; A Matrix is a list of rows
; (list (list 1 2) (list 3 4))

; N -> List-of-number
; extracts the first n list length to make a row
(define (take n row)
  (cond [(zero? n) '()]
        [(empty? row) '()]
        [else (cons (first row) (take (sub1 n) (rest row) )) ])
  )
(take 3 '(1 2 3 4 5)); should return (list 1 2 3)

; N -> List-of-number
; removes the forst n list length and returns a new row without those elements
(define (drop n row)
  (cond [(zero? n) row]
        [(empty? row) row]
        [else (drop (sub1 n) (rest row)) ])
  )
(drop 3 '(1 2 3 4 5)) ; shoudl return (list 4 5)


; N List-of-numbers -> Matrix
; consumes a number n and a list of n^2 numbers and produces a n by n matrix
(define (create-matrix n lon)
  (cond [(empty? lon) '()] ;base case: n is 0, return empty
        [else (cons (take n lon)
                    (create-matrix n (drop n lon)) )])
  )

(check-expect
  (create-matrix 2 (list 1 2 3 4))
  (list (list 1 2)
        (list 3 4)))