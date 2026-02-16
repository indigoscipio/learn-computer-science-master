;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-169) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

;function legal consumes and produces a list of Posns
; the result contains all those posns whose x-coord are between 0 - 100
; and y coordinates are between 0 - 200


; List-of-posns -> List-of-posns
; a list of posn (lop) is the following:
; '()
; Posn List-of-Posns


(define empty-lop '() )
(define sample-lop (cons (make-posn -10 -10) (cons (make-posn 50 50) '())))
(define sample-lop2 (cons (make-posn -100 -55) '()) )

;is-legal is a function that takes a Posn
; it checks if the given value is legal (x is from 0 - 100) and (y is 0 - 200)
; if so, return true. If not return false
(define (is-legal? posn)
  (if (and (and (>= (posn-x posn) 0) (<= (posn-x posn) 100)) (and (>= (posn-y posn) 0) (<= (posn-y posn) 200)))
      #true
      #false
      )
  )


(define (legal lop)
  ; base case: return empty string
  (cond [(empty? lop) '()]
        ; check if x or y is illegal, if so filter it out of the list (return rest lop)
        [(not (is-legal? (first lop))) (legal (rest lop))]
        ;else recurse
        [else (cons (first lop)
                    (legal (rest lop)))]
        )
  )

(legal sample-lop)
(legal sample-lop2)
(check-expect (legal sample-lop) (cons (make-posn 50 50) '()) )