#lang racket

(define (two-fer . args)
  (cond [(empty? args) "One for you, one for me."]
        [(and (pair? args) (string? (car args)) (null? (cdr args))) (string-append "One for " (car args) ", one for me.")]
        [else "One for you, one for me."])
  ; if no name is given, return "One for you, one for me"
  )
(two-fer)
(two-fer '())
(two-fer "Alice" "Bob")
(two-fer "Bob")
