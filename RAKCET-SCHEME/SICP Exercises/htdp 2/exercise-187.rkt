;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise-187) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

(define-struct gp [name score])
; A GamePlayer is a structure: 
;    (make-gp String Number)
; interpretation (make-gp p s) represents player p who 
; scored a maximum of s points
(define sample-gp1 (make-gp "Name" 99)) 
(define sample-gp2 (make-gp "Name2" 777))
(define sample-logp (list sample-gp1 sample-gp2) )


; sort is a function that takes a list of GPs
; and returns a sorted list of GPs by score from largest to smallest
(define (sort> logp)
  (cond [(empty? logp) '()]
        [else (insert (first logp) (sort> (rest logp)) ) ])
  )


;function insert takes a GamePlayer and a list of SORTED GamePlayers
;it inserts gp into a sorted logp
; GamePlayer List-of-GamePlayers -> List-of-GamePlayers
(define (insert gp logp)
  (cond [(empty? logp) (cons gp '()) ]
        [else (if (>= (gp-score gp) (gp-score (first logp) ))
                  (cons gp logp)  
                  (cons (first logp) (insert gp (rest logp)) )
                  )])
  )

(check-expect (sort> sample-logp) (list sample-gp2 sample-gp1))
(sort> sample-logp)