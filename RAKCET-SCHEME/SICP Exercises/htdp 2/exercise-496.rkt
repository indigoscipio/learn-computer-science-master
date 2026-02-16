;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-496) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
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
#|

(sum.v2 '(1 2 3))
== (sum/a '(1 2 3) 0)
== (sum/a '(2 3) 1)
== (sum/a '(3) 3)
== (sum/a '() 6)
== 6
|#



; N -> N 
; computes (* n (- n 1) (- n 2) ... 1) aka factorial function
(define (factorial.v1 n)
  (cond [(zero? n) 1]
        [else (* n (factorial.v1 (sub1 n)) ) ])
  )

; N -> N
; factorial with acclerator
(define (factorial.v2 n0)
  (local (; N N -> N
          ; computes (* n (- n 1) (- n 2) ... 1)
          ; accumulator ...
          (define (factorial.v2/a n acc)
            (cond [(zero? n) acc]
                  [else (factorial.v2/a (sub1 n) (* n acc) ) ])
            ))
    (factorial.v2/a n0 1)
    )
  )
(factorial.v2 3)
(factorial.v2 10)
; when n0 is 10, a is 90
; first call -> n = 10, a = 1
; 2nd call -> n = 9, a = 10
; 3rd call -> n = 8, a = 90



#|
== (factorial.v2/a 3 1) 
== (factorial.v2/a 2 3)

|#