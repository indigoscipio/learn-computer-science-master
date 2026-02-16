;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-493b) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define (sum.v1 alon)
  (cond
    [(empty? alon) 0]
    [else (+ (first alon) (sum.v1 (rest alon)))]))


; List-of-X Number -> Number
; sums up a list of number
(define (sum.v2 alon0)
  (local (; [List-of Number] Number -> Number
          ; computes the sum of the numbers on alon
          ; accumulator ...
          (define (sum.v2/a l acc)
            (cond [(empty? l) acc ]
                  [else (sum.v2/a (rest l) (+ (first l) acc)) ]) ;invariant: at every step, acc contains the sum of all the elements processed so far
            )
          )
    (sum.v2/a alon0 0)
    )
  )
(check-expect (sum.v2 '(1 2 3)) 6)
(sum.v2 '(1 2 3 4 5 6 7))

#|

(sum.v2 '(1 2 3))
== (sum/a '(1 2 3) '())
== (sum/a '(2 3) 1)
== (sum/a '(3) 3)
== (sum/a '() 6)
== 6



|#