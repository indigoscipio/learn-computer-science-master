;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise-227) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; An FSM is one of:
;   – '()
;   – (cons Transition FSM)

(define-struct fs [fsm current])
; A SimulationState.v2 is a structure: 
;   (make-fs FSM FSM-State)
 
(define-struct transition [current next])
; A Transition is a structure:
;   (make-transition FSM-State FSM-State)
 
; FSM-State is a Color.
 
; interpretation An FSM represents the transitions that a
; finite state machine can take from one state to another 
; in reaction to keystrokes 

(define fsm-traffic
  (list (make-transition "red" "green")
        (make-transition "green" "yellow")
        (make-transition "yellow" "red")))

(define sample-fs (make-fs fsm-traffic "green"))

 
(define (state-as-colored-square an-fsm)
  (square 100 "solid" (fs-current an-fsm)))

;(state-as-colored-square sample-fs)


; SimulationState.v2 -> Image
; renders a world state as an image 
(define (render-state fsm)
  (state-as-colored-square fsm))
(render-state sample-fs)

; FSM FSM-State -> FSM-State
; finds the state representing current in transitions
; and retrieves the next field 
(define (find transitions current)
  ;check if the fsm rules contain words equal to given argument
  (cond [(empty? transitions) (error (string-append "not found: " current)) ]
        [(equal? (transition-current (first transitions)) current) (transition-next (first transitions))]
        [else (find (rest transitions) current)])
  )
;(check-expect (find fsm-traffic "red") "green")
;(check-expect (find fsm-traffic "green") "yellow")
;(check-error (find fsm-traffic "black")
;             "not found: black")


; SimulationState.v2 KeyEvent -> SimulationState.v2
; finds the next state from ke and cs
(define (find-next-state fsm ke)
   (make-fs (fs-fsm fsm) (find (fs-fsm fsm) (fs-current fsm)) ))
(find-next-state sample-fs "e");


(define (simulate.v2 fsm s0)
  (big-bang (make-fs fsm s0)
    [to-draw state-as-colored-square]
    [on-key find-next-state]))
(simulate.v2 fsm-traffic "red")