#lang racket

; A Letters is a list of 1string characters
; a ScoreTable is a List-of-[Pair-of-(Letters Number)]
(define score-table '(((#\a #\e #\i #\o #\u #\l #\n #\r #\s #\t) . 1)
                      ((#\d #\g) . 2)
                      ((#\b #\c #\m #\p) . 3)
                      ((#\f #\h #\v #\w #\y) . 4)
                      ((#\k) . 5)
                      ((#\j #\x) . 8)
                      ((#\q #\z) . 10)
                      ))

; String -> Number
; determines scrabble score given the string word
(define (score word)
  (let ((loc (string->list word)))
    ;Looks up a character's value based on a given char
    ; Character -> Number
    (define (get-score char score-table)
      (let ((normalized-char (char-downcase char)))
        (cond [(null? score-table) 0]
              [else (let ((char-found (member normalized-char (car (car score-table))))
                          (char-score (cdr (car score-table)))
                          )
                      (if char-found
                          char-score
                          (get-score char (cdr score-table))
                          )
                      )]
              )    
        )
      )

    ; List-of-characters Number -> Number
    ; accumulator acc builds the corresponding char's value on each iteration, returning the final score
    (define (iter l acc)
      (cond [(null? l) acc]
            [else (iter (cdr l) (+ (get-score (car l) score-table) acc) ) ]
            )
      )
    ; initialize with acc 0
    (iter loc 0)

    ; Iteration 2
    (foldr (lambda (char acc) (+ (get-score char score-table) acc) ) 0 loc)

    ; Iteration 3
    (apply + (map (lambda (char) (get-score char score-table) ) loc))
    )
  )

(score "fad") ;4
(score "f") ;4
(score "zoo") ;12
(score "quirky") ;22