#lang racket

; a Cleaned NANP is a string
; that consists of 10 digit telephone number
; "NXXNXXXXXX"
; where n is any digit from 2 - 9
; and X is any digit from 0 - 9

; Number Number -> List-of-number
; enumerates a number from min up to but not include max
(define (enumerate min max)
  (cond [(>= min max) '()]
        [else (cons min (enumerate (+ min 1) max))])
  )

; Checks if a given char is within a num range from min - max
; Char -> Boolean
(define (is-between-range char min max)
  (let ((num (string->number (string char))))
    (and (>= num min) (<= num max) )
    )
  )

; List-of-chars -> Boolean
; given a 10 digit phone number, checks if the area code (first digit) is valid
; area code is the 1st digit of the phone number
(define (is-valid-area-code? char-nums)
  (is-between-range (list-ref char-nums 0) 2 9)
  )

; List-of-chars -> Boolean
; given a 10 digit phone number, checks if the exchange code (fourth digit) is valid
; area code is the 1st digit of the phone number
(define (is-valid-exchange-code? char-nums)
  (is-between-range (list-ref char-nums 3) 2 9)
  )
; List-of-char -> Boolean
; given a list of digits, checks if it starts with the character #\1
(define (contain-country-prefix? char-nums)
  (eq? (car char-nums) #\1)
  )

; Ff input is 11 digit number and if the first digit starts with 1
; drop it and return the rest unchanged otherwise signal error
; if its 10 digit return as is
; List-of-char -> Maybe List-of-char
(define (strip-country-prefix char-nums)
  (cond [(eq? (length char-nums) 10) char-nums]
        [(eq? (length char-nums) 11) (if (eq? (car char-nums) #\1)
                                         (cdr char-nums)
                                         #f
                                         )]
        [else #f]
        )
  )

; String -> Cleaned NANP
(define (clean phone-number)
  ; make sure the input are all valid numbers
  ; clean the whitespace, plus or minus, dashes, dots
  (let* ((chars (string->list phone-number))
         (num-chars (filter char-numeric? chars))
         (valid-num-chars (strip-country-prefix num-chars))
         )
    ; first validation: 10 or 11 digit length -> 10 digit length
    (if valid-num-chars (if (and (is-valid-area-code? valid-num-chars)
                                 (is-valid-exchange-code? valid-num-chars)
                                 )
                            (list->string valid-num-chars)
                            (error "Invalid area/exchange code")
                            )
        (error "Invalid num char"))
    
    )
  )


(clean "+1 (613)-995-0253")
(clean "613-995-0253")
(clean "1 613 995 0253")
(clean "613.995.0253")
(clean "123456789") ; invalid
(clean "22234567890") ;invalid
(clean "123-abc-7890") ;invalid
(clean "123-@:!-7890") ;invalid
(clean "1 (123) 456-7890") ;invalid area code
(clean "(023) 456-7890") ;invalid area code starts with 0
(clean "1 (223) 156-7890") ;invalid exchange code starts with 1
(clean "(223) 056-7890") ;invalid exchange code starts with 0
(clean "1 (023) 456-7890") ;invalid

