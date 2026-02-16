;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-492) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
; A SimpleGraph is a [List-of Connection]
; A Connection is a list of two items:
;   (list Node Node)
; A Node is a Symbol.


(define sample-graph
  '((A (B E))
    (B (E A))
    (C (D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))

; Node SimpleGraph -> Node
; determine the node that is connected to a-node in sg
(define (neighbors n sg)
  (cond [(empty? sg) (error "neighbor: not a node")]
        [(equal? n (first (first sg))) (second (first sg))]
        [else (neighbors n (rest sg)) ]
        )
  )
 
; [List-of Node] Node Graph -> [Maybe Path]
; finds a path from some node on lo-Os to D
; if there is no path, the function produces #false
(define (find-path/list lo-Os D G seen)
  (cond
    [(empty? lo-Os) #false]
    [else (local ((define candidate
                    (find-path (first lo-Os) D G (cons (first lo-Os) seen))))
            (cond
              [(boolean? candidate)
               (find-path/list (rest lo-Os) D G seen)]
              [else candidate]))]))

; Node Node Graph -> [Maybe Path]
; finds a path from origination to destination in G
; if there is no path, the function produces #false
(define (find-path origination destination G seen)
  (cond
    [(symbol=? origination destination) (list destination)]
    [else (local ((define next (neighbors origination G))
                  (define candidate
                    (find-path/list next destination G (cons origination seen))))
            (cond
              [(boolean? candidate) #false]
              [(member? origination seen) #false]
              [else (cons origination candidate)]))]))
(find-path 'A 'E sample-graph '()) 

