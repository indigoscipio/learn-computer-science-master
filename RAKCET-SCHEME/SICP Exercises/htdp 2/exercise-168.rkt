;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-168) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

;function translate consumes and produces lists of posns
; for each (make-posn x y) in the former, the latter contains (make-posn x (+ y 1))
; List-of-posns -> List-of-posns
; a list of posn (lop) is the following:
; '()
; Posn List-of-Posns


(define empty-lop '() )
(define sample-lop (cons (make-posn 1 2) (cons (make-posn 3 4) '())))

(define (translate lop)
  (cond [(empty? lop) '()]
        [else (cons (make-posn (posn-x (first lop)) (add1 (posn-y (first lop)))) (translate (rest lop)) ) ]
        )
  )

(translate sample-lop)
(check-expect (translate sample-lop) (cons (make-posn 1 3) (cons (make-posn 3 5) '())) )