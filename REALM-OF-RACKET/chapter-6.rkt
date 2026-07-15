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
(define state0 (ws (snake 'down (list (posn 80 80) (posn 82 82)))
                   (list (food (posn 25 25) 3) (food (posn 33 33) 6))))
(define food0 (food (posn 10 10) 5))
(define food1 (food (posn 25 25) 3))
(define snake0 (snake 'down (list (posn 3 3) (posn 3 4))))

; -----------------------------------------------

; CONSTANTS
(define SEGMENT-SIZE 8)
(define FOOD-SIZE 12)
(define SCENE-WIDTH 256)
(define SCENE-HEIGHT 256)
(define SNAKE-SEGMENT (circle SEGMENT-SIZE "solid" "black"))
(define SNAKE-SPEED 2)
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

; -----------------------------------------------

; RENDER
(define (render ws)
  (let* ((foods (ws-foods ws))
         (foods-pos (map food-posn foods))
         (snake-segs (snake-segs (ws-snake ws)))
         (foods+empty (foldr (λ (food-pos acc) (place-image
                                                FOOD
                                                (posn-x food-pos)
                                                (posn-y food-pos)
                                                acc
                                                )) EMPTY-SCENE foods-pos))
         (whole-scene (foldr  (λ (seg acc) (place-image
                                            SNAKE-SEGMENT
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
; keep it simple for now

; -----------------------------------------------

state0

; KEY EVENTS
; can't go opposite direction
(define (handle-key w k)
  (cond [(key=? k "up")
         (ws (snake 'up (snake-segs (ws-snake w)))
             (ws-foods w))]
        [(key=? k "down")
         (ws (snake 'down (snake-segs (ws-snake w)))
             (ws-foods w))]
        [(key=? k "up")
         (ws (snake 'up (snake-segs (ws-snake w)))
             (ws-foods w))]
        [(key=? k "up")
         (ws (snake 'up (snake-segs (ws-snake w)))
             (ws-foods w))]
        [else w]
        )
  )
(handle-key state0 "up")


; -----------------------------------------------

; MAIN BIG BANG
#|
(define (init-snake)
  (big-bang ...
    (on-key handle-key)
    (to-draw render)
    (on-tick move)
    )
  )
|#