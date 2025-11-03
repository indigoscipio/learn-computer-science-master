#lang racket


; given current position in word list, does the pattern match?
; starting at the beginning
; List-of-chars List-of-chars Number -> Boolean
(define (check-match chars pattern)
  ; base case: first character doesn't match -> fail
  (cond [(null? pattern) #t]
        [(null? chars) #f] ; no more chars to check, pattern found
        [(not (equal? (car chars) (car pattern))) #f] ;first doesn't equal, return false
        [else (check-match (cdr chars) (cdr pattern))]
        )
  )
;(check-match '(#\h #\e #\l #\l #\o) '(#\l #\l)) ; should return false
;(check-match '(#\h #\i) '(#\h #\i)) ; return true
;(check-match '(#\h) '(#\h #\i)) ;return false, chars exhausted but pattern still remains
;(check-match '() '(#\h #\i)) ; no text left but pattern remains, false
;(check-match '() '()) ; return true


; String String -> Boolean
; given a word and pattern, returns a booelan indicating if its found or not
(define (find-match word pattern)
  ; outer loop: start from position 0 to n-m
  (let ((word-chars (string->list word))
        (pattern-chars (string->list pattern))
        )

    ; List-of-chars -> MaybeNumber
    ; Find patterns at different starting positions
    ; eg "slide" the window by n+1 length
    (define (outer-loop loc curr-pos)
      (cond [(< (length loc) (length pattern-chars)) #f]
            [(check-match loc pattern-chars) curr-pos]
            [else (outer-loop (cdr loc) (+ curr-pos 1)) ]
            )
      )
    (outer-loop word-chars 0)
    
    )
  
  )
(find-match "hello" "ll")
(find-match "unknown" "")
(find-match "hey" "h")
