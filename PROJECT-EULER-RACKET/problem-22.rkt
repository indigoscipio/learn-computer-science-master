#lang racket

#|
PROBLEM 22
NAMES SCORES

Using names.txt (right click and 'Save Link/Target As...'),
a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order.
Then working out the alphabetical value for each name, multiply this value by its alphabetical position
in the list to obtain a name score.
For example, when the list is sorted into alphabetical order, COLIN, which is worth   

(names.txt structure: "MARY","PATRICIA","LINDA","BARBARA","ELIZABETH","JENNIFER","MARIA",...)

3+15+12+9+14 = 53
is the 938th name in the list, so COLIN would obtain a score of 938 * 53 = 49714

what is the total of all the name scores in the file?

answer:

1. ok so i need to find a way to read file here in racket ifirst, its very long
2. then parse those names into a list, sorted alphabetically
3. then for each name find its name score by multiplying ap * av = ns
4. then calculate all name scores


|#

(define NAMES (file->string "names.txt"))
(define NAMES-SM (file->string "names-sm.txt"))



; char -> number
; given a char, returns its alphabetical value
(define (char-score char)
  (+ (- (char->integer char) (char->integer #\A)) 1)
  )

; string -> number
; given a name (str), returns its alphabetical name score
(define (name-score str)
  (foldr + 0(map char-score (string->list str)))
  )

; file -> number
(define (sum-name-scores input)
  (let* ((names (map (λ (str) (string-replace str "\"" "")) (string-split input ",")))
         (sorted-names (sort names string<?))
         (names-len (length sorted-names))
         )

    (define (sum-all xs curr-pos)
      (cond [(>= curr-pos names-len) 0]
            [else (let ((curr-name (list-ref xs curr-pos) ))
                    (+ (* (name-score curr-name) curr-pos) (sum-all xs (+ 1 curr-pos)) )
                    )])
      )

    (sum-all sorted-names 1)
    )
  )
(sum-name-scores NAMES-SM) ;small list returns 36027
(sum-name-scores NAMES) ;returns 870873746