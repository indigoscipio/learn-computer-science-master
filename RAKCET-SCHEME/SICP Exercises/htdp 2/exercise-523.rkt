;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-523) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
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
(define init-state (make-pstate (make-bank 1 3) (make-bank 0 0) "left" '()))
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
;(final? final-state)

; Bank -> List-of-Banks
;Generate all valid possible groups of 1 or 2 people that can board the boat
(define (possible-groups b)
  (local [(define m (bank-m b))
          (define c (bank-c b))
          (define groups 
            (list (make-bank 1 0) (make-bank 0 1) 
                  (make-bank 2 0) (make-bank 0 2) 
                  (make-bank 1 1)))]
    (filter (lambda (group) 
              (and (>= m (bank-m group)) 
                   (>= c (bank-c group))))
            groups)))
(possible-groups (make-bank 2 2))

(define (make-new-state s m-move c-move)
  (local [(define boat (pstate-boat s))
          (define left (pstate-left s))
          (define right (pstate-right s))
          (define history (pstate-history s))
          (define new-history (cons s history))]
    (if (string=? boat "left")
        ; Moving from left to right
        (make-pstate (make-bank (- (bank-m left) m-move)
                     (- (bank-c left) c-move))
                    (make-bank (+ (bank-m right) m-move)
                     (+ (bank-c right) c-move))
                    "right"
                    new-history)
        ; Moving from right to left
        (make-pstate (make-bank (+ (bank-m left) m-move)
                     (+ (bank-c left) c-move))
                    (make-bank (- (bank-m right) m-move)
                     (- (bank-c right) c-move))
                    "left"
                    new-history))))

; PuzzleState -> Boolean
; checks if missionaries are safe on both banks
(define (valid-state? s)
  (local [(define left (pstate-left s))
          (define right (pstate-right s))
          (define left-m (bank-m left))
          (define left-c (bank-c left))
          (define right-m (bank-m right))
          (define right-c (bank-c right))]
    (and (or (>= left-m left-c) (zero? left-m))    ; Left bank safe
         (or (>= right-m right-c) (zero? right-m)) ; Right bank safe
         (>= left-m 0) (>= left-c 0)               ; No negative counts (optional)
         (>= right-m 0) (>= right-c 0)
         (member? (pstate-boat s) '("left" "right")))))
(valid-state? init-state)

; List-of-Puzzle-States -> List-of-Puzzle-States
; generates list of valid next states based on given l
(define (create-next-states states)
  (cond [(empty? states) '()]
        [else
         (local [(define current (first states))
                 (define current-bank (if (string=? (pstate-boat current) "left")
                                         (pstate-left current)
                                         (pstate-right current)))
                 (define opposite-bank (if (string=? (pstate-boat current) "left")
                                          (pstate-right current)
                                          (pstate-left current)))
                 (define groups (possible-groups current-bank))
                 (define new-states
                   (map (lambda (group)
                          (make-new-state current 
                                         (bank-m group) (bank-c group)))
                        groups))]
           (append
            (filter valid-state? new-states)
            (create-next-states (rest states))))]))
(create-next-states (list init-state)) 