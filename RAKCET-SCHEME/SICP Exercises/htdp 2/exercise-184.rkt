;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise-184) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

(list (string=? "a" "b") #false)
(check-expect (list (string=? "a" "b") #false)
              (list #false #false)
              )

(list (+ 10 20) (* 10 20) (/ 10 20))
(check-expect (list (+ 10 20) (* 10 20) (/ 10 20))
              (list 30 200 0.5)
              )


(list "dana" "jane" "mary" "laura")
