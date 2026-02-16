;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-520) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
; A Bank is a (make-bank N N)
; - m: number of missionaries
; - c: number of cannibals
(define-struct bank [m c])

; A PuzzleState is a struct
; left = list (missionaries cannibals) on the left bakn
; right = list (missionaries cannibals) the right bank
; boat = location of the boat ("left" or "right")
; history = list of all previous states that led to the current state
(define-struct pstate [left right boat history])

;example 1: two missionaries on the left, boat on the right, and two cannibals on the right
(define init-state (make-pstate (make-bank 3 3) (make-bank 0 0) "left" '()))
(define mid-state (make-pstate (make-bank 2 1) (make-bank 1 2) "right" (list init-state))  )
(define final-state (make-pstate (make-bank 0 0) (make-bank 3 3) "right" (list init-state))  )

; PuzzleState -> Boolean
; Checks if all missionaries and cannibals are on the right bank
(define (final? s) 
  (and   (and (zero? (bank-m (pstate-left s)))
              (zero? (bank-c (pstate-left s))))
         (and (= (bank-m (pstate-right s)) 3)
              (= (bank-c (pstate-right s)) 3))
         (string=? (pstate-boat s) "right" ))

  )
(final? final-state)


(define (create-next-states l)

  )


; PuzzleState -> PuzzleState
; is the final state reachable from state0
; generative creates a tree of possible boat rides 
; termination ???


#|
(check-expect (solve initial-puzzle) final-puzzle)
 
(define (solve state0)
  (local (; [List-of PuzzleState] -> PuzzleState
          ; generative generates the successors of los
          (define (solve* los)
            (cond
              [(ormap final? los)
               (first (filter final? los))]
              [else
               (solve* (create-next-states los))])))
    (solve* (list state0))))

|#