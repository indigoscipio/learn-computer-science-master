#lang racket

; a word is a list of characters
; a sentence is a list of words

; a dictionary is a listof pairof (char num) where each char maps to unique number
; example: '((#\a . 1) (#\b . 2))

; global assoc list with 27 letteres, assign value 0 by default

; word -> listof number
(define (map-wd wd)
  (let ((chars (string->list wd)))
    ; listof chars . number . listof pairof (char number) -> listof number
    (define (map-wd-h xs i result)
      ; already seen? just do assoc and just write current number
      ; else record it in result and recurse
      (cond [(empty? xs) (reverse result)]
            [else (let* ((fst-char (car xs))
                         (matched-pair (assoc fst-char result))
                         )
                    (if matched-pair
                        (map-wd-h (cdr xs) i (cons matched-pair result))
                        (map-wd-h (cdr xs) (+ i 1) (cons (cons fst-char i) result))
                        )              
                    )]
            )
      )
    (map cdr (map-wd-h chars 0 '()))
    )  
  )
(map-wd "and")
(map-wd "dick")
(map-wd "helllo")


; word (encrypted) word (dictionary) current-map -> new-map or #f
(define (match-word encr-wd dict-wd curr-map)
  (let ((encr-chars (string->list encr-wd))
        (dict-chars (string->list dict-wd))
        )

    (define (match-word-h encr-xs dict-xs c-map)
      (cond [(empty? encr-xs) c-map]
            [else (let* ((encr-char (car encr-xs))
                        (dict-char (car dict-xs))
                        (curr-pair (assoc encr-char c-map))
                        (dict-values (member dict-char (map cdr c-map)))
                        (available? (not dict-values))
                        )
                    
                    ;encry char already on the map
                    (if curr-pair
                        (and (equal? (cdr curr-pair) dict-char)
                             (match-word-h (cdr encr-xs) (cdr dict-xs) c-map)
                             )
                        ;encry char is not on the map
                        (if available?
                            (match-word-h (cdr encr-xs) (cdr dict-xs) (cons (cons encr-char dict-char) c-map) ) ;add it
                            #f
                            )
                        )
                    )]

            )
      )
    (match-word-h encr-chars dict-chars curr-map)
    
    )
  )
(match-word "sy" "no" '((#\g . #\a)))


; (listof string) (listof string) map -> map or #f
(define (solve words dict map)
  (cond[(empty? words) map]
       [else (let* ((first-wd (car words))
                   (rest-wd (cdr words))
                   (mapped-wd (map-wd first-wd))
                   )
               (ormap (λ (cand) (let ((new-map (map-wd rest-wd)))
                                  (if (equal? (map-wd first-wd) (map-wd cand))
                                      (match-word first-wd cand map)
                                      #f
                                      ) 
                                  ) ) dict)
               )])
  )
(solve '("qymm" "xsb") '("and" "dick" "jane" "puff") '((#\x . #\a) (#\s . #\n) (#\b . #\d)))



(define (decrypt input)
  ; for each item in xs, try to match it in dict
  ; if theres a simialr pattern try to apply it to the rest and see if it match
  ; no two letter can be the same
   0
  )
(decrypt '((and dick jane puff spot yertle)
           (bjvg xsb hxsn xsb qymm xsb rqat xsb pnetfn)))