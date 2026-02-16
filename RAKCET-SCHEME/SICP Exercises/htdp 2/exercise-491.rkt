;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-491) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
; A SimpleGraph is a [List-of Connection]
; A Connection is a list of two items:
;   (list Node Node)
; A Node is a Symbol.


(define a-sg
  '((A B)
    (B C)
    (C E)
    (D E)
    (E B)
    (F F)))



;(check-expect (path-exists? 'A 'E a-sg) #true)
;(check-expect (path-exists? 'A 'F a-sg) #false)



; Node SimpleGraph -> Node
; determine the node that is connected to a-node in sg
(check-expect (neighbor 'A a-sg) 'B)
(check-error (neighbor 'G a-sg) "neighbor: not a node")
(define (neighbor n sg)
  (cond [(empty? sg) (error "neighbor: not a node")]
        [(equal? n (first (first sg))) (second (first sg))]
        [else (neighbor n (rest sg)) ]
        )
  )
;(neighbor 'A a-sg)

#|
; Node Node SimpleGraph [List-of Node] -> Boolean
; is there a path from origin to destination
; assume there are no paths for the nodes in seen
(define (path-exists? origin destination sg seen)
  (cond [(symbol=? origin destination) #t]
        [else (path-exists? (neighbor origin sg) destination sg (cons origin seen) )]
        )
  )
;(path-exists? 'A 'E a-sg '())
|#

(define (path-exists.v2? origin destination sg)
  (local (; Node Node SimpleGraph [List-of Node] -> Boolean
          (define (path-exists?/a origin seen)
            (cond [(symbol=? origin destination) #t]
                  [(member? origin seen) #f]
                  [else (path-exists?/a (neighbor origin sg)
                                        (cons origin seen) )]
                  )
            ) )
    (path-exists?/a origin '()) 
    )
  )
(check-expect (path-exists.v2? 'A 'E a-sg) #true)
(check-expect (path-exists.v2? 'A 'F a-sg) #false)