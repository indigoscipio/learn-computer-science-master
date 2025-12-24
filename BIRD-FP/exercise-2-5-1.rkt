#lang racket

;richard bird functional programming book exercise
;2.5.1
; define versions of functions A and V using patterns for the second arguent
; edfine which use patterns for both arguments.
; draw up a table showing the values of and and or for each version

; x A True -> x
; x A False -> false
; x V true -> true
; x v False -> x

; Boolean Boolean -> Boolean
(define (my-and a b)
  (cond [b a]
        [else #f])
  )

; Boolean BOolean -> Boolean
(define (my-or a b)
  (cond [b #t]
        [else a])
  )


; =======================
; versions which use both arguments

; AND
; True A True -> T
;
;
;

; OR
; 
(or #f 5)



