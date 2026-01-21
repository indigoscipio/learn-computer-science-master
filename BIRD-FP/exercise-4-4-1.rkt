#lang racket
(require 2htdp/image)

#|
state -- (direction, pen, point) 
direction -- num 
pen -- bool 
point -- (num,num) 
command -- state -+ state

direction
north 0
east 1
south 2
west 3

move .. command 
move (O,p,(x,y)) = (O,p,(x - l,y)) 
move (l,p, (x, y)) = (l,p,(x,y + 1)) 
move (2,p, (x, y)) = (2,p,(x + 1,y)) 
move (3,p, (x,y)) = (3,p,(x,y-1)) 

; turtle takes a command
; and returns a state
turtle :: [command] -> [state]
turtle = scan applyto (0, false, (0,0))
applyto x f = f x

display:: [command] -> [char]
display = layout . picture . trail . turtle

|#

; =====================================

;; Directions: 0 (N), 1 (E), 2 (S), 3 (W)
;; Pen: #t (down), #f (up)
;; Point: (cons x y)
(struct turtle-state (dir pen point) #:transparent)
(define initial-state (turtle-state 0 #f (cons 0 0)))
(define state1 (turtle-state 0 #f (cons 8 0)))

;-------

; COMMANDS
; MOVE
; turtlestate -> turtlestate
(define (move state)
  (let* ((dir (turtle-state-dir state))
         (pen (turtle-state-pen state))
         (point (turtle-state-point state))
         )
    (cond [(eq? dir 0) (turtle-state dir pen (cons (- (car point) 1) (cdr point)))] ; go up 1 pt
          [(eq? dir 1) (turtle-state dir pen (cons (car point) (+ 1 (cdr point))))] ; go right
          [(eq? dir 2) (turtle-state dir pen (cons (+ (car point) 1) (cdr point))) ]  ; go down
          [else (turtle-state dir pen (cons (car point) (- (cdr point) 1))) ] ; go left
          )
    )
  )
(move state1)

; RIGHT/LEFT
; turtlestate->turtlestate
(define (right state)
  (let* ((dir (turtle-state-dir state))
         (pen (turtle-state-pen state))
         (point (turtle-state-point state))
         )
    (turtle-state (modulo (+ 1 dir) 4) pen point )
    )
  )

(define (left state)
  (let* ((dir (turtle-state-dir state))
         (pen (turtle-state-pen state))
         (point (turtle-state-point state))
         )
    (turtle-state (modulo (- dir 1) 4) pen point )
    )
  )
(left state1)

; UP/DOWN
(define (up state)
  (let* ((dir (turtle-state-dir state))
         (pen (turtle-state-pen state))
         (point (turtle-state-point state))
         )
    (turtle-state dir #t point)
    )
  )

(define (down state)
  (let* ((dir (turtle-state-dir state))
         (pen (turtle-state-pen state))
         (point (turtle-state-point state))
         )
    (turtle-state dir #f point)
    )
  )
(up state1)

; ========================================

; 4.4.2
; Define a function (block k) which causes the turtle to trace a solid square of side k.
;repeat:: number command -> list-of-commands
(define (repeat n cmd)
  (cond [(zero? n) '()] ;stop applying
        [else (cons cmd (repeat (- n 1) cmd)) ])
  )


; number -> list-of-commands
(define (block k)
  (let ((row (repeat k move))
        (pivot1 (list right move right))
        (pivot2 (list left move left))
        )

    ; number -> list-of-commands
    (define (block1 curr-n)
      (cond [(zero? curr-n) '()] ;stop
            [(<= curr-n 1) row]
            [(even? curr-n) (append row pivot1 (block1 (- curr-n 1)))] ;curr-n is even, use pivot1
            [else (append row pivot2 (block1 (- curr-n 1)))]; curr-n is odd, use pivot2
            )
      )
    (block1 k)
    )
  )

; ========================================
; 4.4.3 Define trail and layout.

; state list-of-commands -> list-of-points
(define (trail state cmds)
  (foldr  (λ (cmd acc) (let* ((curr-state (car acc))
                              (history (cdr acc))
                              (next-state (cmd curr-state))
                              (new-pt (turtle-state-point next-state))
                              (old-pt (turtle-state-point curr-state))
                              )
                         (if (and (turtle-state-pen next-state)
                                  (not (equal? old-pt new-pt))
                                  )
                             (cons next-state (cons new-pt history))
                             (cons next-state history)
                             )
                         ))
          (cons state '())
          cmds)
  )
(trail (turtle-state 0 #t (cons 0 0)) (block 2))

