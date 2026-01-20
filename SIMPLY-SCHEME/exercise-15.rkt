#lang simply-scheme

(define (drop-once x xs)
  (cond [(empty? xs) xs]
        [(equal? (first xs) x) (bf xs)]
        [else (se (first xs) (drop-once x (bf xs)))]
        )
  )
(drop-once 3 '(1 2 3 4 5 3))

(define (find-smallest sent)
  (define (find-smallest1 curr-smallest sentence)
    (cond [(empty? sentence) curr-smallest]
          [else (let* ((fst (first sentence))
                       (rest (bf sentence))
                       )
                  (if (before? curr-smallest fst)
                      (find-smallest1 curr-smallest rest) ;keep it
                      (find-smallest1 fst rest ) ;update cur smallest
                      )
                  )]
          )
    )
  ; initialize
  (if (empty? sent) '() (find-smallest1 (first sent) (bf sent)))
  )
(find-smallest '(4))

; selection sort (sort of)
; ss-sort:: list-of-number -> list-of-number
(define (ss-sort xs)
  (cond [(empty? xs) '()]
        [else (se (find-smallest xs) (ss-sort (drop-once (find-smallest xs) xs ))) ])
  )
(ss-sort '(i wanna be your man))

; ==================

;take
(define (take n sent)
  (cond [(empty? sent) '()]
        [(zero? n) '()]
        [else (se (first sent) (take (- n 1) (bf sent)))]
        )
  )
(take 3 '(h e l l o))

;drop
(define (drop n sent)
  (cond [(empty? sent) sent]
        [(zero? n) sent]
        [else (drop (- n 1) (bf sent))]
        )
  )


; merge:: sentence sentence -> sentence
(define (merge left right)
 (cond [(empty? left) right]
       [(empty? right) left]
       [(before? (first left) (first right)) (se (first left) (merge (bf left) right)) ] ;but left
       [else (se (first right) (merge left (bf right)))]
       )
  )
(merge '(1 4 8) '(2 5 6 10))


; merge sort
(define (mergesort sent)
  (let* ((mid (floor (/ (count sent) 2)))
        (left-half (take mid sent))
        (right-half (drop mid sent))
        )
    (cond [(<= (count sent) 1) sent]
          [(merge (mergesort left-half) (mergesort right-half) )])
    )
  )
(mergesort '(1 99 2 -100 3 64 4 5))

; ========================================
#|
15.1 write a procedure to binary
> (to–binary 9)
1001
> (to–binary 23)
10111
|#

(define (to-binary n)
  (if (equal? n 0) '(0) (to-binary1 n))
  )

(define (to-binary1 n)
   (cond [(zero? n) '()]
          [else (let* ((q (quotient n 2))
                      (r (remainder n 2))
                      )
                  (se (to-binary1 q) r)
                  )])
  )
(to-binary 0)
(to-binary 9) ;1001 => 1x8 + 1x4 + 0x2 + 1x1
(to-binary 23) ;10111 => 1x4 + 1x2 + 1x1


; ========================================

#|
15.2 A "palindrome" is a sentence that reads the same backward as forward. Write a predicate palindrome? that 
takes a sentence as argument and decides whether it is a palindrome. For example:
> (palindrome? '(flee to me remote elf))
#T
> (palindrome? '(flee to me remote control))
#F
Do not reverse any words or sentences in your solution.
|#

;palindrome?:: sentence -> boolean
(define (palindrome? sent)
  (palindrome?-helper (accumulate word sent))
  )

;palindrome?-helper:: word -> boolean
(define (palindrome?-helper wd)
  ; veyr difficult since no reverse alloweed
  ; flatten the list into words
  ; check if first xs = last xs
  ; continue until it reaches the middle
  (cond [(empty? wd) #t]
        [(empty? (bf wd)) #t]
        [else (let* ((fst (first wd))
                     (lst (last wd))
                     (drop-fl (bl (bf wd)))
                     )
                (cond [(equal? fst lst) (palindrome?-helper drop-fl)] ;drop both first and last
                      [else #f])
                )]
        )
  )
; maybe i'/m overcomplicating this?
(palindrome? '()) ;vacuously true
(palindrome? '(flee to me remote elf))
(palindrome? '(ba o ab)) ; should return true
(palindrome? '(he eh))
(palindrome? '(flee to me remote control))

; ========================================