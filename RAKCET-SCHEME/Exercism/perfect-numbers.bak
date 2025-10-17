#lang racket

#|
(define rules '((3 . "Pling")
                (5 . "Plang")
                (7 . "Plong")))

(define (convert number)
  (let ((result (apply string-append (filter (lambda (string) (not (string=? string "")) )
                                             (map (lambda (rule) (if (= (remainder number (car rule)) 0)
                                                                     (cdr rule)
                                                                     ""
                                                                     )) rules)))))
    (if (string=? result "") (number->string number) result)
    
    )
  )
|#

#|
; Number -> String
; given a number, converts it to a corresponding raindrop sound
; if number is divisble by 3, add "Pling"
; if number is divisble by 5, add "Plang"
; if number is divisble by 7, add "Plong"
; if number is not divisible by 3,5, or 7 the result should be returned as a string
(define (convert number)
  (let ((result (string-append (if (= (remainder number 3) 0) "Pling" "" )
                               (if (= (remainder number 5) 0) "Plang" "" )
                               (if (= (remainder number 7) 0) "Plong" "" )
                               )))
    
    
    (if (string=? result "") (number->string number) result)
    
    )  
  )
|#

; test cases
(convert 3) ; "Pling"
(convert 1) ; "Pling"
(convert 28) ;divisible by 7 but not 3, -> return "Plong"
(convert 30) ;divisbly by 3,5 but not 7 -> return "PlingPlang"
(convert 34) ;not divisible by 3,5 or 7 -> return 34