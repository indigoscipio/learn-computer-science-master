;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise-231) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
;Exercise 231. Eliminate quote in favor of list from these expressions:

'(1 "a" 2 #false 3 "c")
(list 1 "a" 2 #false 3 "c")
(cons 1 (cons "a" (cons 2 (cons #false (cons 3 (cons "c" '()))))))

'()
(list)

'(("alan" 1000)
  ("barb" 2000)
  ("carl" 1500))
(list (list "alan" 1000) (list "alan" 2000) (list "alan" 1500))
(cons (cons "alan" (cons 1000 '())) (cons (cons "alan" (cons 1000 '())) (cons (cons "alan" (cons 1000 '())) '())))

