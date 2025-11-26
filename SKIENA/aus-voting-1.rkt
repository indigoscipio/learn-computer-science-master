#lang racket

;; take : Nat (listof X) -> (listof X)
(define (take n xs)
  (cond [(zero? n) '()]
        [(null? xs) '()]
        [else (cons (car xs)
                    (take (sub1 n) (cdr xs)))]))

;; drop : Nat (listof X) -> (listof X)
(define (drop n xs)
  (cond [(zero? n) xs]
        [(null? xs) xs]
        [else (drop (sub1 n) (cdr xs))]))

; find-eliminated : (listof Nat-counts) -> (listof candidate-ids)
; given a list of candidate votes, returns the lowest count
(define (find-eliminated votes)

  (define min-vote (apply min votes))
  (define (loop votes index result)
    (cond [(null? votes) (reverse result) ]
          [else (let* ((curr-vote (car votes)))
                  (if (<= curr-vote min-vote)
                      (loop (cdr votes) (+ 1 index) (cons index result))
                      (loop (cdr votes) (+ 1 index) result)
                      )
                  )])
    )
  
  (loop votes 1 '())

  )
(find-eliminated '(2 4 2)) ; should reutrn '(1 3)
(find-eliminated '(1 2)) 

;; ballot->current-choice : (listof Nat) (listof Nat) -> Nat
;; Given a ballot and a list of eliminated candidates,
;; return the first candidate on the ballot who is not eliminated.
(define (ballot->curr-choice ballot eliminated)
  (cond [(not (member (car ballot) eliminated)) (car ballot)]
        [else (ballot->curr-choice (cdr ballot) eliminated)]
        )
  )
;(ballot->curr-choice '(1 2 3) '(1)) ; should return 2
;(ballot->curr-choice '(2 1 3) '(1 2)) ; should return 3
;(ballot->curr-choice '(1 2 3) '()) ; should return 1
;(ballot->curr-choice '(3 2 1) '(3 2)) ;should return 1
;(ballot->curr-choice '(3 1 2) '(1 2 3)) ;all eliminated, impossible case

; count-result : Nat (listof ballot) (listof Nat-eliminated) -> Nat
; given candidate id and all ballots, compute how many count that candidate has
(define (count-ballot candidate-id ballots eliminated)
  (define (loop lob result)
    (cond [(null? lob) result]
          [(eq? (ballot->curr-choice (car lob) eliminated) candidate-id) (loop (cdr lob) (+ 1 result))]
          [else (loop (cdr lob) result)]
          )
    )
  (loop ballots 0)
  )
#|
(count-ballot 2 '((1 2 3)
                  (2 1 3)
                  (2 3 1)
                  (1 2 3)
                  (3 1 2)) '(1))
|#

; (listof Candidate-ID) (listof ballot) (listof eliminated) -> (listof Nat)
; counts how many vote each candidates have.
(define (count-ballots loc lob eliminated)
  (define active-candidates 
    (filter (lambda (c) (not (member c eliminated) )) loc))
  
  (map (lambda (c) (count-ballot c lob eliminated)) 
       active-candidates))
#|
(count-ballots '(1 2 3) '((1 2 3)
                          (2 1 3)
                          (2 3 1)
                          (1 2 3)
                          (3 1 2)) '())
|#


;; has-winner? : (listof Nat) (listof Nat-ids) Nat -> (or Nat #f)
;; returns candidate-id if they have > 50% of total-votes, else #f
(define (has-winner? votes candidate-ids total-ballots)
  (define majority-threshold (/ total-ballots 2))
  (define (loop votes ids)
    (cond [(null? votes) #f]
          [(> (car votes) majority-threshold) (car ids)]
          [else (loop (cdr votes) (cdr ids))]))
  (loop votes candidate-ids))


;; all-tied? : (listof Nat) -> Boolean
;; returns true if all remaining candidates have same count
(define (all-tied? votes)
  (cond [(null? votes) #t]
        [(null? (cdr votes)) #t]
        [else (andmap (lambda (v) (= v (car votes))) votes)]))

; List-of-X -> List-of-string
; simulates the australian vote given a list of inputs
; n (list-of-candidates) (list-of-ballot)
(define (aus-vote input)
  ; parse the candidates
  ; a candidates is a list of string
  ; a ballots is a list of number
  (let* ((candidates (take (car input) (cdr input)))
        (ballots (drop (+ (length candidates)1) input))
        )
    ballots
    )

  ; count the ballot
  ; detect when >50%
  )

#|
(aus-vote '(3
            "John Doe"
            "Jane Smith"
            "Sirhan Sirhan"
            (1 2 3)
            (2 1 3)
            (2 3 1)
            (1 2 3)
            (3 1 2)))
|#

; read ballot
; keep track of candidate
; recount vote based on preference
; detect when someone wins
; or detect when everyone remaining is tied