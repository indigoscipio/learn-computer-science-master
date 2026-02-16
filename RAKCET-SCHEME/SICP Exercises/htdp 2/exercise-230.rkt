;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise-230) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
(define-struct fsm [initial transitions final])
; An FSM.v2 is a structure: 
;   (make-fsm FSM-State LOT FSM-State)
; A LOT is one of: 
; – '() 
; – (cons Transition.v3 LOT)
; A Transition.v3 is a structure: 
 
(define-struct ktransition [current key next])
; A Transition.v2 is a structure:
;   (make-ktransition FSM-State KeyEvent FSM-State)

; FSM-State is a Color.
; interpretation An FSM represents the transitions that a
; finite state machine can take from one state to another 
; in reaction to keystrokes
; Initial = white
; Middle = Yellow
; End = Green
; Error = Red
(define fsm-guess
  (list
   (make-ktransition "red" "a" "yellow")
   (make-ktransition "white" "a" "yellow")  ;Initial -> Middle
   (make-ktransition "yellow" "b" "yellow") ; Middle -> Middle
   (make-ktransition "yellow" "c" "yellow") ; Middle -> Middle
   (make-ktransition "yellow" "d" "green")))  ; Middle -> End

(define sample-fsm (make-fsm "white" fsm-guess "green"))

 
(define (state-as-colored-square fsm)
  (square 100 "solid" (fsm-initial fsm)))
;(state-as-colored-square sample-fsm)

; SimulationState.v2 -> Image
; renders a world state as an image 
(define (render-state fsm)
  (state-as-colored-square fsm))
(render-state sample-fsm)


; FSM FSM-State -> FSM-State
; finds the state representing current in transitions and retrieves the next field 
(define (find ktransitions current key)
  ;check if the current key matches with one of the ktransitions
  (cond [(empty? ktransitions) "red"]
        [(and (equal? (ktransition-key (first ktransitions)) key)
              (equal? (ktransition-current (first ktransitions)) current))
         (ktransition-next (first ktransitions))]
        [else (find (rest ktransitions) current key)]
        )
  )
;(find fsm-guess "white" "a") ; should move to yellow
;(find fsm-guess "white" "g") ; should move to red
;(find fsm-guess "yellow" "b")
;(find fsm-guess "yellow" "c")
;(find fsm-guess "yellow" "d")
;(find fsm-guess "yellow" "f")


; SimulationState.v2 KeyEvent -> SimulationState.v2
; finds the next state from ke and cs
(define (find-next-state fsm ke)
   (make-fsm (find (fsm-transitions fsm) (fsm-initial fsm) ke) (fsm-transitions fsm) (fsm-final fsm) ))

; SimulationState.v2 -> Boolean
(define (end? fsm)
  (equal? (fsm-initial fsm) (fsm-final fsm))
  )

(define (simulate.v2 ws)
  (big-bang ws
    [to-draw state-as-colored-square]
    [on-key find-next-state]
    [stop-when end? render-state]
    ))
(simulate.v2 sample-fsm)
