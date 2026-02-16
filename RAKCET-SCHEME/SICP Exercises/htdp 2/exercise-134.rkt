;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-134) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define (contains? alon name)
  (cond [(empty? alon) #false]
    [(string=? (first alon) name) #true ]
        [else (contains? (rest alon) name) ]
        )
  )


(define sample-list-2 (cons "Alice" (cons "Bob" (cons "Flatt" (cons "Carol" '())))))
(define sample-list-empty '() )

(contains? sample-list-2 "Alice")
(contains? sample-list-empty "Alice")