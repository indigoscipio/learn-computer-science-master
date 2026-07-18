#lang racket

(require 2htdp/universe 2htdp/image)

; REALM OF RACKET
; CHAPTER 6

; a few notes after reading the whole chapter, but i wanna
; implement it my own way
; worldstate that stores the snake and the food
; snake:: direction segments
; food:: position and expire time?

; next state:
; if the food is eaten, snake grows 1 segment
; otherwise just slither

; helpers:
; can-eat: check if a snake can eat the food, is there nearby food that the head can grab?
; eat: reduce food, add snake segment
; grow: grows the snake
; slither: new head, all but last segment
; next-head: create new head baesd on direction
; posn-move: general function that moves based on given dx dy p
; age-food: repalce expired food with new food - maybe do this later
; expire-food: makes food expired
; snake-dead, game over, etc.
; selectors: head, tail, change direction, body

; -----------------------------------------------

; DATA STRUCTURE

; a WorldState is a struct
; main state that keeps track of the snake game
(struct ws (snake foods) #:transparent)

; a Snake is a struct
; dir is a symbol of either: 'up, 'down, 'left, 'right
; segs takes a list of posns that stores the snakes segment
(struct snake (dir segs) #:transparent)

; a Food is a struct
; where posn is the food's position, and expire is an integer
(struct food (posn expire) #:transparent)

; a Posn is a struct
; stores a x,y point of something
(struct posn (x y) #:transparent)

; Example States
(define state0 (ws (snake 'down (list (posn 80 80) (posn 80 74) (posn 80 73) (posn 80 72)))
                   (list (food (posn 32 32) 3) (food (posn 32 34) 6))))
(define food0 (food (posn 10 10) 5))
(define food1 (food (posn 25 25) 3))
(define foods0 (list food0 food1))
(define snake0 (snake 'down (list (posn 3 3) (posn 3 4))))

; -----------------------------------------------

; CONSTANTS
(define GRID-SIZE 8)
(define FOOD-EXPIRED-TIME 8)
(define SEGMENT-SIZE (quotient GRID-SIZE 2))
(define FOOD-SIZE GRID-SIZE)
(define FOOD-DISTANCE-THRESHOLD SEGMENT-SIZE)
(define SCENE-WIDTH (* GRID-SIZE 32))
(define SCENE-HEIGHT (* GRID-SIZE 32))
(define SNAKE-SEGMENT (circle SEGMENT-SIZE "solid" "black"))
(define SNAKE-SPEED GRID-SIZE)
(define EMPTY-SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT))
(define FOOD (square FOOD-SIZE "solid" "red"))
(define TEXT-SIZE-HEADING 32)
(define TEXT-SIZE-BODY 14)

; -----------------------------------------------

; HELPERS
(define (snake-head sn)
  (car (snake-segs sn))
  )

(define (snake-body sn)
  (cdr (snake-segs sn))
  )

(define (all-but-last xs)
  (cond [(null? (cdr xs)) '()]
        [else (cons (car xs) (all-but-last (cdr xs)))])
  )

; -----------------------------------------------

; RENDER
(define (render w)
  (let* ((foods (ws-foods w))
         (foods-pos (map food-posn foods))
         (snake-segs (snake-segs (ws-snake w)))
         (foods+empty (foldr (λ (food-pos acc) (place-image
                                                FOOD
                                                (posn-x food-pos)
                                                (posn-y food-pos)
                                                acc
                                                )) EMPTY-SCENE foods-pos))
         (whole-scene (foldr  (λ (seg acc) (place-image
                                            SNAKE-SEGMENT
                                            ;(+ (posn-x seg) (/ GRID-SIZE 2))
                                            (posn-x seg)
                                            (posn-y seg)
                                            acc
                                            )) foods+empty snake-segs)))
    whole-scene
    )
  )
(render state0)

; -----------------------------------------------

; MOVEMENT

; Snake -> Posn
(define (calc-next-snake-head-pos sn)
  (let ((curr-head (snake-head sn)))
    (cond [(equal? (snake-dir sn) 'left) (posn (- (posn-x curr-head) SNAKE-SPEED)
                                               (posn-y curr-head))]
          [(equal? (snake-dir sn) 'right) (posn (+ (posn-x curr-head) SNAKE-SPEED)
                                                (posn-y curr-head))]
          [(equal? (snake-dir sn) 'up) (posn (posn-x curr-head)
                                             (- (posn-y curr-head) SNAKE-SPEED))]
          [(equal? (snake-dir sn) 'down) (posn (posn-x curr-head)
                                               (+ (posn-y curr-head) SNAKE-SPEED))]
          
          [else curr-head]
          )
    )
  )


; EATING
; check if theres close food
; if so, eat it and grow the snake body, else just keep snake state
; lets keep food disappearing away fromnow

; list of foods -> list of foods
; inside boundary range: (GRID-SIZE / 2) to SCENE-WIDTH - (GRID-SIZE / 2)
(define (spawn-food fds)
  ; places food randomly on the inside canvas boundary
  (let* ((min-boundary (/ GRID-SIZE 2))
         (max-boundary (- SCENE-WIDTH (/ GRID-SIZE 2)))        
         (new-food (food (posn (random min-boundary max-boundary) (random min-boundary max-boundary)) FOOD-EXPIRED-TIME)))
    (cons new-food fds)
    )
  )

; MOVING
; create new head - calc n using curr head coord
; remove last sgement - combine in segs, remove last tail

; c = sqrt(a^2 + b^2)
(define (calc-distance p1 p2)
  (sqrt (+ (sqr (- (posn-x p2) (posn-x p1)))
           (sqr (- (posn-y p2) (posn-y p1)))))
  )

; posn food -> boolean
(define (close-to-head? new-head f)
  (<= (calc-distance new-head (food-posn f)) FOOD-DISTANCE-THRESHOLD)
  )

; worldstate -> worldstate
(define (next-ws w)
  (let* ((sn (ws-snake w))
         (foods (ws-foods w))
         (new-head  (calc-next-snake-head-pos sn))
         (fresh-foods (filter (λ (f) (not (close-to-head? new-head f))) foods))
         )
    (if (= (length fresh-foods) (length foods))
        ; when food is eaten, spawn one in new location
        (ws (snake (snake-dir sn) (cons new-head (all-but-last (snake-segs sn))))
            foods
            )
        (ws (snake (snake-dir sn) (cons new-head (snake-segs sn) ))
            (spawn-food fresh-foods)
            )
        )
    )
  )
(next-ws state0)


; -----------------------------------------------

; KEY EVENTS
; up, down, left, right -> change direction
; opposite direction -> either die/dont do anything
; WorldState KeyEvent -> WorldState
(define (handle-key w ke)
  ; moving in free direction? move
  ; moving in opposite direction? just return state as is
  ; else keep current state
  (let ((ke-sym (string->symbol ke))
        (curr-dir (snake-dir (ws-snake w))))
    (cond [(is-opposite-dir? curr-dir ke) w]
          [(member ke '("up" "down" "left" "right")) (ws (snake ke-sym (snake-segs (ws-snake w)))
                                                         (ws-foods w))]
          [else w]
          )
    )
  )


; symbol string -> boolean
(define (is-opposite-dir? d ke)
  (cond [(and (equal? d 'up) (equal? ke "down")) #t]
        [(and (equal? d 'down) (equal? ke "up")) #t]
        [(and (equal? d 'left) (equal? ke "right")) #t]
        [(and (equal? d 'right) (equal? ke "left")) #t]
        [else #f]
        )
  )


; -----------------------------------------------

; MAIN BIG BANG

(define (init-snake)
  (big-bang state0
    (on-key handle-key)
    (to-draw render)
    (on-tick next-ws 0.1)
    )
  )
(init-snake)
