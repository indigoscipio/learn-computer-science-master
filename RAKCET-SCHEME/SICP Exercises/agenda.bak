#lang sicp

;; make-wire : -> wire
;; A wire is a procedure that accepts messages:
;;  - 'get-signal → returns current signal
;;  - 'set-signal! v → sets signal to v, if different, and runs actions
;;  - 'add-action! proc → adds proc to actions list
(define (make-wire)
  ; action procs stores a list of lambda
  (let ((signal-value 0)
        (action-procs '())
        )

    ; Calls all procedures from a given list of procs
    ; List-of-procs -> 'done
    (define (call-each-procs procs)
      (cond [(null? procs) 'done]
            [else ((car procs)) (call-each-procs (cdr procs))])
      )

    ; (number -> symbol) ; sets signal, returns 'unchanged or 'updated
    (define (set-signal! new-value)
      (cond [(= signal-value new-value) 'unchanged]
            [else (set! signal-value new-value)
                  (call-each-procs action-procs)
                  'updated])
      )

    ; Adds action to a wire
    ;((-> void) -> void) ; adds procedure to run on change
    (define (accept-action-procedure! proc)
      (set! action-procs (cons proc action-procs))
      (proc)
      )

    ; Dispatches message
    (define (dispatch m)
      (cond [(eq? m 'get-signal) signal-value]
            [(eq? m 'set-signal!) set-signal!]
            [(eq? m 'add-action!) accept-action-procedure!]
            [else (error "Unknown Message make-wire" m)]
            )
      )
  
    dispatch
    )
  )

(define a (make-wire))
(define (get-signal wire) (wire 'get-signal))
(define (set-signal! wire new-value)
  ((wire 'set-signal!) new-value))
(define (add-action! wire action-procedure)
  ((wire 'add-action!) action-procedure))

(add-action! a (lambda () (display "gg")))
(get-signal a)
(set-signal! a 2)
(get-signal a)



; A Time segement is a pair
; cons Time Queue
; time = Number
; queue = List-of-procesures
(define (make-time-segment time queue)
  (cons time queue)
  )
(define ts-example (make-time-segment 0 (list (lambda (x) x) (lambda (x) x))))

(define (segment-time s) (car s))
(segment-time ts-example)

(define (segment-queue s) (cdr s))
(segment-queue ts-example)

; Creates a empty agenda
; An agenda is a list of time segments
(define (make-agenda) (list 0))

; returns the current simulation time
(define (current-time agenda)
  (car agenda)
  )

(define (empty-agenda? agenda)
  (null? agenda)
  )

; Agenda -> ???
; Extracts the first item on the agenda
(define (first-agenda-item agenda)
  (car agenda)
  )

(define (remove-first-agenda-item! agenda)
  0
  )

; Number [Procedure] Agenda -> ???
; Adds action procedure to agenda
(define (add-to-agenda! time action agenda)
  0
  )




; Function boxes are like logic gates
; they watch for inputs, react when it changes, and update the output wire after a delay

; Actionis a procedure/lambda of zero arguments
; that gets registered to a wire using add-action!


#|

; Exercise 3.28
; or-gate as primitive function box
; Number (0 or 1) -> Number (0 or 1)
(define (logical-or s1 s2)
  (cond [(or (= s1 1) (= s2 1)) 1]
        [(and (= s1 0) (= s2 0)) 0]
        [else (error "Invalid signal(s)" s1 s2)])
  )

; or-gate as primitive function box
; Number (0 or 1) -> Number (0 or 1)
(define (logical-and s1 s2)
  (cond [(or (= s1 0) (= s2 0)) 0]
        [(and (= s1 1) (= s2 1)) 1]
        [else (error "Invalid signal(s)" s1 s2)])
  )
; not gate as primitive function box
; Number (0 or 1)
(define (logical-not s)
  (cond ((= s 0) 1)
        ((= s 1) 0)
        (else (error "Invalid signal" s))))


(define (inverter input output)
  (define (invert-input)
    (let ((new-value (logical-not (get-signal input))))
      (after-delay inverter-delay
                   (lambda () (set-signal! output new-value)))))
  (add-action! input invert-input) 'ok)


;exercise 3.29
; or gate using inverter
(define (or-gate.v2 a1 a2 output)
  (let ((na1 (make-wire))
        (na2 (make-wire))
        (and-out (make-wire))
        )
    (inverter a1 na1)
    (inverter a2 na2)
    (and-gate na1 na2 and-out)
    (inverter and-out output)
    'ok
    )  
  )



;; or-gate : wire wire wire -> symbol
;; Attaches an or-gate to wires a1 and a2, outputting to `output`.
;; Registers an action procedure on both input wires, which:
;; - computes logical-or of input signals
;; - schedules a change on output after or-gate-delay
(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    (let ((new-value (logical-or (get-signal a1) (get-signal a2)) ))
      (after-delay or-gate-delay
                   (lambda () (set-signal! output new-value))
                   )
      )
    )
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok
  )

; Half Adder
(define (half-adder a b s c)
  (let ((d (make-wire)) (e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)
    'ok))


; Full Adder
(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire)) (c1 (make-wire)) (c2 (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)
    'ok))

; Exercise 3.30
;; ripple-carry-adder : (listof wire) (listof wire) (listof wire) wire -> 'ok
(define (ripple-carry-adder a b s c)
  (define (iter a-wires b-wires s-wires carry-in)
    (cond [(null? a-wires) 'ok] ; no more bits to process
          [else (let ((carry-out (make-wire))
                      (full-adder (car a-wires) (car b-wires) carry-in (car s-wires) carry-out)
                      (iter (cdr a-wires) (cdr b-wires) (cdr s-wires) carry-out )
                      ))])
    )
  (iter a b s c)
  )
|#
