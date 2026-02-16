#lang sicp

; A Binary is either a 1 or 0

; Number -> List-of-[Binaries]
; Decimal to binary using the diviison by 2 algorithm
; Susanna Epp Discrete Math
(define (decimal->binary n)
  ; Acc stores the list-of-binaries
  (define (iter number acc)
    (cond [(= number 0) (if (null? acc) '(0) acc )]
          [else (iter (floor (/ number 2) ) (cons (modulo number 2) acc) ) ] ;else keep dividing by 2 and store the reminder in the acc
          )
    ) 
  (iter n '())
  )
(decimal->binary 0)
(decimal->binary 10)
(decimal->binary 500)


#|
(let ((result "RESULT"))
   (cond [(<= n 0) result]
         [else (modulo n 2)])
    )
|#

