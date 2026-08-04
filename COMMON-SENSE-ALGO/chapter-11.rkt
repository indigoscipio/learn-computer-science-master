#lang racket

; CHAPTER 11

; STAIRCASE PROBLEM
; 5 steps
; 2 step: 1,1 - 2
; 3 step: 1,1,1 - 2,1 - 1,2 - 3

; number -> number
(define (ways-to-climb n)
  (cond [(< n 0) 0]
        [(= n 1) 1]
        [(= n 2) 2]
        [(= n 3) 4]
        [else (+ (ways-to-climb (- n 1))
                 (ways-to-climb (- n 2))
                 (ways-to-climb (- n 3))
                 )]
        )
  )
(ways-to-climb 3)

; number -> number
(define (ways-to-climb-v2 n)
  (cond [(< n 0) 0]
        [(or (= n 1) (= n 0)) 1]
        [else (+ (ways-to-climb-v2 (- n 1))
                 (ways-to-climb-v2 (- n 2))
                 (ways-to-climb-v2 (- n 3))
                 )]
        )
  )
(ways-to-climb-v2 3)

; ================================

; ANAGRAM GENERATION
; a -> a
; ab -> ab, ba
; abc -> abc; acb, bac, bca, cab, cba
; abcd -> (permutations of abc) + d (insert in every of those)

; base case-> 1 letter, just return it
; 2 letter -> anagram of the substring/rest

; Any list-of-any -> list-of-list-of-any
; for simplification purpose lets just do lst of symbols instead of string
; idont wanna waste time parsing string/converting back and forth
(define (insert-to-each x xs)
  (cond [(null? xs) (cons (list x) xs)]
        [else (let* ((curr-xs (car xs))
                    (rest-xs (cdr xs))
                    (first-placement (cons x xs))
                    ; places x at the very begining of entire list xs
                    (rest-placement (map (λ (lst) (cons curr-xs lst))
                                          (insert-to-each x rest-xs)))
                   
                    )
                ; a goes to beginning of the whole list
                ; all placement = put a in front of everything +
                ; keep b first, and insert a into '(c d)
                (append (list first-placement) rest-placement )
                )])
  )
(insert-to-each 'a '()) ;'((a))
(insert-to-each 'a '(b)) ; '((a b)(b a))
(insert-to-each 'a '(b c d)) ; '((a b c d) (b a c d) (b c a d) (b c d a))

; list-of-any -> list-of-list-of-any
(define (anagram xs)

  (cond [(null? xs) '()]
        [(null? (cdr xs)) (list xs) ] ; 1 item
        [else (let* ((curr-xs (car xs))
                     (rest-xs (cdr xs))
                     (rest-anagram (anagram rest-xs))
                     )
                (apply append (map (λ (lst) (insert-to-each curr-xs lst))
                                   rest-anagram))
                )])
  
  )
(display 'anagram)(newline)
(anagram '(a))
(anagram '(a b))
(anagram '(a b c d))

; ==================================================

; EXERCISES

#|
1
Use recursion to write a function that accepts an array of strings and
returns the total number of characters across all the strings. For example,
if the input array is ["ab", "c", "def", "ghij"], the output should be 10 since there
are ten characters in total.
answer:
|#

; assume input is valid alphabetical list of string
(define (char-count-in-los xs)
  (let ((chars-xxs (map string->list xs) ))

    #|
    ; list-of-list-of-chars -> number
    (define (count curr-xxs)
      (cond [(null? curr-xxs) 0]
            [(char? (car curr-xxs)) (+ 1 (count (cdr curr-xxs)))]
            [else (+ (count (car curr-xxs))
                     (count (cdr curr-xxs))) ])
      )
    (count chars-xxs)
    |#

    ; tail recursive version
    (define (count curr-xxs result)
      (cond [(null? curr-xxs) result]
            [(char? (car curr-xxs)) (count (cdr curr-xxs) (+ 1 result)) ]
            [else (count (cdr curr-xxs)
                         (count (car curr-xxs) result)) ])
      )
    (count chars-xxs 0)
    

    )
  )
(char-count-in-los '("ab" "c" "def" "ghij")) ; returns 10
(char-count-in-los '("abc" "d"))

; =========================================

#|
2
Use recursion to write a function that accepts an array of numbers and
returns a new array containing just the even numbers.

|#

(define (only-evens xs)
  
  (cond [(null? xs) '()]
        [(zero? (remainder (car xs) 2))
         (cons (car xs) (only-evens (cdr xs)))]
        [else (only-evens (cdr xs))]
        )
  
  )
(only-evens '(0 1 2 3 4 5 6 7 8 9 10)) ;'(0 2 4 6 8 10)

; =========================================

#|
 3
 A particular numerical sequence is known as triangular numbers. The pattern
begins as 1, 3, 6, 10, 15, 21, and continues onward. To calculate the next
number in the sequence, we add the previous number from the sequence
plus N, where N corresponds to the place in the sequence where the number
lies. For example, the seventh number in the sequence is 28, since it’s the
seventh number in the pattern, so we add the number 7 plus 21 (the previous
number in the sequence). Write a function that accepts a number for N and
returns the correct number from the series; that is, if the function was
passed the number 7, the function would return 28.

answer:
|#

; numbers: 1 3 6 10 15 21 28
; term/n:  1 2 3 4  5  6  7
; assume n is posint
(define (triangular-numbers n)
  ; number number -> number
  (define (helper curr-value prev-value curr-term)
    (cond [(> curr-term n) curr-value]
          [else (let ((next-value (+ curr-value prev-value)))
                  (helper next-value curr-value (+ 1 curr-term))
                  )]
          )
    )
  
  ; initalize with 1st term with value of 1
  (if (equal? n 1)
      1
      (helper 3 1 2)
      )
  
  )
(triangular-numbers 1) ;1
(triangular-numbers 5) ;15
(triangular-numbers 7) ;28