;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-493) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
; [List-of X] -> [List-of X]
; constructs the reverse of alox
 
(check-expect (invert '(a b c)) '(c b a))
 
(define (invert alox)
  (cond
    [(empty? alox) '()]
    [else
     (add-as-last (first alox) (invert (rest alox)))]))
 
; X [List-of X] -> [List-of X]
; adds an-x to the end of alox
 
(check-expect (add-as-last 'a '(c b)) '(c b a))
 
(define (add-as-last an-x alox)
  (cond
    [(empty? alox) (list an-x)]
    [else
     (cons (first alox) (add-as-last an-x (rest alox)))]))



(define (invert.v2 alox)
  (local (; [List-of X] [List-of X] -> [List-of X]
          ; constructs the reverse of alox
          ; accumulator a is the list of all those 
          ; items on alox0 that precede alox 
          ; in reverse order
          (define (invert.v2/a l acc)
            (cond [(empty? l) acc]
                  [else (invert.v2/a (rest l)
                                     (cons (first l) acc) ) ])
            )
          )
    (invert.v2/a alox '())
    )
  )
(invert.v2 '(1 2 3 4))