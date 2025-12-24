#lang racket

; exercise 2.4.1
; Richard Bird Functional Programming

; a Date is a (listof Number Number Number)
; (list d m y)
; where d = day (1-31), m = month (1-12), any y = year (1900 - 2025)

; =====================================

; helper functions
(define (get-day date)
  (car date)
  )

(define (get-month date)
  (cadr date)
  )

(define (get-year date)
  (caddr date)
  )

; =====================================

; given a target date and current date,
; returns the age of the target P as a whole number of years
(define(age target-date curr-date)
  ; just compute the difference in years - am i oversimplifying the logic?

  ; example
  ; target: 1 1 2005
  ; curr: 12 24 2025
  ; 2025 - 2005 - 20 years
  ;(- (get-year curr-date) (get-year target-date))
  (let ((year-diff (- (get-year curr-date) (get-year target-date) )))
    (if   (or (< (get-month curr-date) (get-month target-date))
              (and (= (get-month curr-date) (get-month target-date))
                   (< (get-day curr-date) (get-day target-date))
                   ))
          (- year-diff 1)
          year-diff

          )
    )



  ; if curr month < target month, no birthday
  ; curr mont = target month,
  
  )
(age '(15 6 2005) '(15 6 2025))