#lang racket

#|
PROBLEM 19
Counting Sundays

You are given the following information, but you may prefer to do some research for yourself.

1 Jan 1900 was a Monday.
Thirty days has a September.
April, June, and November.

All the rest have thirty one,
Saving February Alone,
which has twenty-eight, rain or shine
and on leap years, twenty-nine

A leap year occurs on any year evenly divisible by 4
but not on a century unless its divisible by 400

How many Sundays fell on the first of the month during
the twentieth century (1 Jan 1901 to 31 Dec 2000)?

answer:
let me understand this question first
we have a few information here

lets map it out
starts at monday, 1 Jan 1900

Sep, Apr, Jun, Nov -> 30
Jan, Mar, May, July, Aug, Oct, Dec -> 31
Feb -> depends on leap year

the question asks for how many sundays fell on the first of the month
during the twentienth century (from 1 Jan 1901 - 31 Dec 2000)

lets think about how i can solve this
since it just asks for how many sunday, we can represent each day as number or symbol
hmm i could make a struct here something like date struct but I think that would be unecessary, not sure
|#

; a Month is a number
; interpretation one of the following:
; 1 -> January, 2 -> February, 3 -> March, 4 -> April, 5 -> May, 6 -> June,
; 7 -> July, 8 -> August, 9 -> September, 10 -> October, 11 -> November, 12 -> December

; A day is a number
; interpretation one of the following:
; 1 -> Mon, 2 -> Tue, 3 -> Wed, 4 -> Thu, 5 -> Fri, 6 -> Sat, 7 -> Sun

(define (is-leap-year? year)
  (and (zero? (remainder year 4))
      (or (not (zero? (remainder year 100)))
          (zero? (remainder year 400))
          )
      )
  )
(is-leap-year? 1600)

; given a month, a  date, and a year,
; do i need days-in-month or just count-sundays-inomnth? this one is simpler
; maybe im overcomplicating this
(define (days-in-month year month)
  (cond [(member month '(4 6 9 11)) 30] ;handle 
        [(member month '(1 3 5 7 8 10 12)) 31] ;handle 31 days
        [else (if (is-leap-year? year)
                  29
                  28
                  ) ] ;handle leap year
        )
  )
(days-in-month 1900 1) ;january 1900


#|
Walk through time month by month. What does that walk look like?
You know Jan 1 1900 = Monday. Let's say Monday = 1, Tuesday = 2, ... Sunday = 7 (or 0, your choice).
If a month starts on day d and has n days in it, what day does the next month start on?
Can you write that as a simple expression?
That's the core of the whole solution. Get that expression right and the rest falls into place.

a month has starts on day 1 and has 31 days
nxt month starts on (remainder 31 7)


|#

; given a year, counts how many sundays fell on the first of the month up to the end of that year
(define (counting-sundays year)
  ; start from 1901, count how many sundays in a month, then go to the next one
  (define (loop d m y)
    (cond [(> y year) 0]; stop
          [(> m 12) (loop d 1 (+ 1 y))]
          [else (let* ((n (days-in-month y m) )
                       (next-start-day (if (= (remainder (+ d n) 7) 0) 7 (remainder (+ d n) 7)) ))
                  (cond [(and (> y 1900) (= d 7)) (+ 1 (loop next-start-day (+ 1 m) y) ) ] ; increment
                        [else (loop next-start-day (+ 1 m) y) ] ; next month
                        )
                  )])
    )
  (loop 1 1 1900) ; initialize with 1 Jan 1900, which was a monday
  )
(counting-sundays 2000)