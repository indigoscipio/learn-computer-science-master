;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-426) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

(quick-sort< (list 11 8 14 7))
==
(append (quick-sort< (list 8 7))
        (list 11)
        (quick-sort< (list 14)))
==
(append (append (quick-sort< (list 7))
                (list 8)
                (quick-sort< '()))
        (list 11)
        (quick-sort< (list 14)))
==
(append (append (append (quick-sort< '())
                        (list 7)
                        (quick-sort< '()))
                (list 8)
                (quick-sort< '()))
        (list 11)
        (quick-sort< (list 14)))
==
(append (append (append '()
                        (list 7)
                        '())
                (list 8)
                '())
        (list 11)
        (quick-sort< (list 14)))
==
(append (append (list 7)
                (list 8)
                '())
        (list 11)
        (quick-sort< (list 14)))
==
(append (list 7 8)
        (list 11)
        (quick-sort< (list 14)))
==
(append (list 7 8)
        (list 11)
        (append (quick-sort< '())
                (list 14)
                (quick-sort< '())))
==
(append (list 7 8)
        (list 11)
        (append (append '())
                (list 14)
                (append '())))
==
(append (list 7 8)
        (list 11)
        (append '()
                (list 14)
                '()))
==
(append (list 7 8)
        (list 11)
        (list 14))
==
(list (list 7 8 11 14))