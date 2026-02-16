;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-382) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
; An FSM is a [List-of 1Transition]
; A 1Transition is a list of three items:
;   (cons FSM-State (cons String (cons FSM-State '())))
; - The first FSM-State is the **current state**.
; - The String is the **allowed key event** for the transition.
; - The second FSM-State is the **next state**.


 
; data examples 
(define fsm-traffic
  '(("red" "green") ("green" "yellow") ("yellow" "red")))

 
; [X Y] [List-of [List X Y]] X -> Y
; finds the matching Y for the given X in alist
(define (find alist x)
  (local ((define fm (assoc x alist)))
    (if (cons? fm) (second fm) (error "not found"))))

 
#|
; FSM-State FSM -> FSM-State 
; matches the keys pressed by a player with the given FSM
(define (simulate state0 transitions)
  (big-bang state0 ; FSM-State
    [to-draw
      (lambda (current)
        (overlay (text current 24 "black")
                 (square 100 "solid" current) ))]
    [on-key
     (lambda (current key-event)
       (local ((define transition (find transitions current) ))
         (if (key=? key-event (first transition))
             (second transition)
             current
             )
         )
        )]))
;(simulate "red" fsm-traffic)
|#

; Rewritten versionx
; An XMachine is a nested list of this shape:
; (list 'machine (('initial FSM-state)) [List-of-X1T])
; (cons 'machine (cons (list 'initial FSM-state) [List-of-X1T]))

; An X1T is a nested list of this shape:
; (list 'action (('state FSM-State) ('next FSM-State)))
; (cons 'action (cons (list (list 'state FSM-state) (list 'next FSM-state)) '() ))


; a BW machine configuration
(define xm0
  '(machine ((initial "red"))
     (action ((state "red") (next "green")))
     (action ((state "green") (next "yellow"))) 
     (action ((state "yellow") (next "red")))))
 
; loab: '((color "red") (size "large"))).
; symbol: '(color)
; [List-of Attribute] Symbol -> String or #false
; Finds the attribute value associated with sym
(define (find-attr loab s)
  (local ((define result (assq s loab)))
    (if (false? result)
        #f
        (second result)
        )
    )
  )
;(find-attr '((action "yellow")) 'action)

(define (xm-state0 xm)
  (second (first (first (rest xm))))
  )
;(check-expect (xm-state0 xm0) "red")

; [List-of Attribute] or Xexpr.v2 -> Boolean
; is x a list of attributes
(define (list-of-attributes? x)
  (cond [(empty? x) #t]
        [else (local ( (define possible-attribute (first x))
                       )
                (cons? possible-attribute)
                ) ])
  )

; Xexpr.v2 -> [List-of Attribute]
; retrieves the list of attributes of xe
(define (xexpr-attr xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) '()]
      [else (local ((define loa-or-x (first optional-loa+content)))
              (if (list-of-attributes? loa-or-x)
                  loa-or-x
                  '()
                  ) 
              )])))
(xexpr-attr (first xm0))

; Xexpr.v2 -> ???
; extracts the contents of given xml representation
(define (xexpr-content xe)
  ;extract everything after the tag
  (local ((define optional-loa+content (rest xe)))
    (cond [(empty? optional-loa+content) '()];check if there's an attribute list, if true remove it to get only the content
          [else (local ((define loa-or-x (first optional-loa+content)))
                  (if (list-of-attributes? loa-or-x)
                      (rest optional-loa+content)
                      optional-loa+content
                      )
                  ) ])
    )
  )

; '(("red" "green") ("green" "yellow") ("yellow" "red")))
(define (xm->transitions xm)
  (local (; X1T -> 1Transition
          (define (xaction->action xa)
            (list (find-attr (xexpr-attr xa) 'state)
                  (find-attr (xexpr-attr xa) 'next))))
    (map xaction->action (xexpr-content xm))))
;(xm->transitions xm0)
;(check-expect (xm->transitions xm0) fsm-traffic) 

