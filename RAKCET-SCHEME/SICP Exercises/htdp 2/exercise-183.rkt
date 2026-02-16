;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise-183) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

;(cons "a" (list 0 #false))
;(cons "a" (cons 0 (cons #false '())))
;(list "a" 0 false)

;(list (cons 1 (cons 13 '())))
;(cons (cons 1 (cons 13 '())) '())
;(list (list 1 13))


;(cons (list 1 (list 13 '())) '())
;(cons (cons 1 (cons (cons 13 (cons '() '())) '())) '())
;(list (list 1 (list 13)) )


;(list '() '() (cons 1 '()) )
;(cons '() (cons '() (cons (cons 1 '()) '())))
;(list '() '() (list 1))


(cons "a" (cons (list 1) (list #false '())))
(cons "a" (cons (cons 1 '()) (cons #false (cons '() '()))))
(list "a" (list 1) #false '())