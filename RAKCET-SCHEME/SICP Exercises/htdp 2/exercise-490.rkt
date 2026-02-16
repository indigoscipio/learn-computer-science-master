;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-490) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define (relative->absolute l)
 (reverse
  (foldr (lambda (element accu) (cons (+ element (first accu)) accu))
         (list (first l))
         (reverse (rest l)))))


; X List-ox-X -> List-of-Y
; places x at the end of the list
(define (add-at-end x l)
  (append l (list x))
  )
(add-at-end 1 '(3 2))
(add-at-end 3 '(1 2))

; List-of-X -> List-of-X (Reversed)
(define (my-reverse l)
  (my-reverse/a l '())
  )

(define (my-reverse/a l acc)
  (cond [(empty? l) acc]
        [else (my-reverse/a (rest l) (cons (first l) acc) ) ]
        )
  )
(my-reverse/a '(1 2 3 4) '())