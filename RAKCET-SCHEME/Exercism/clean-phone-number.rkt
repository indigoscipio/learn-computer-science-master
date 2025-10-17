#lang racket

; a Cleaned NANP is a string
; that consists of 10 digit telephone number
; "NXXNXXXXXX"
; where n is any digit from 2 - 9
; and X is any digit from 0 - 9

; Number Number -> List-of-number
(define (enumerate min max)
  (cond [(>= min max) '()]
        [else (cons min (enumerate (+ min 1) max))])
  )

; Checks if a given char is within a num range from min - max
; Char -> Boolean
(define (is-between-range char min max)
  (let ((target (- (char->integer char) (char->integer #\0))))
    (member target (enumerate min (+ max 1)))
    )
  )

; List-of-chars -> Boolean
; given a 10 digit phone number, checks if the area code (first digit) is valid
; area code is the 1st digit of the phone number
(define (is-valid-area-code? char-nums)
  (not (not (is-between-range (list-ref char-nums 0) 2 9)))
  )
;(is-valid-area-code? '(#\1 #\5 #\9)) ;false
;(is-valid-area-code? '(#\0 #\5 #\9)) ;false
;(is-valid-area-code? '(#\2 #\5 #\9)) ;true

; List-of-chars -> Boolean
; given a 10 digit phone number, checks if the exchange code (fourth digit) is valid
; area code is the 1st digit of the phone number
(define (is-valid-exchange-code? char-nums)
  (not (not (is-between-range (list-ref char-nums 3) 2 9)))
  )
;(is-valid-exchange-code? '(#\1 #\1 #\2 #\4)) ;true
;(is-valid-exchange-code? '(#\1 #\1 #\2 #\0)) ;false
;(is-valid-exchange-code? '(#\1 #\1 #\2 #\1)) ;false
;(is-valid-exchange-code? '(#\1 #\1 #\2 #\2)) ;true

; List-of-char -> Boolean
; given a list of digits, checks if it starts with the character #\1
(define (contain-country-prefix? char-nums)
  (eq? (car char-nums) #\1)
  )

; String -> Cleaned NANP
(define (clean phone-number)
  ; make sure the input are all valid numbers
  ; clean the whitespace, plus or minus, dashes, dots
  (let* ((chars (string->list phone-number))
         (num-chars (filter char-numeric? chars))
         )

    ; check if its 10 digits
    ; if its 10 digit go to the next one
    ; if its 11 digit check if the first digit is 1, if so go to the next one    
    (if (and (> (length num-chars) 9)
             (<= (length num-chars) 11)
             )
        (if (eq? (length num-chars) 11)
            (if (eq? (car num-chars) #\1)
                (if (and (is-valid-area-code? (cdr num-chars))
                         (is-valid-exchange-code? (cdr num-chars)))
                    (list->string (cdr num-chars))
                    "invalid"
                    )
                "invalid"
                )
            (if (and (is-valid-area-code? num-chars)
                     (is-valid-exchange-code? num-chars))
                (list->string num-chars)
                "invalid"
                )
            )
        "invalid"
        )
    
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
