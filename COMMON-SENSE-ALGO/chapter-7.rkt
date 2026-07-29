#lang racket

; chapter 7
; AVG OF EVEN

; functional style/list based
(define (avg-of-even xs)
  (define (loop curr-xs even-sum even-count)
    (cond [(null? curr-xs) (/ even-sum even-count)]
          [(even? (car curr-xs)) (loop (cdr curr-xs)
                                       (+ (car curr-xs) even-sum)
                                       (+ 1 even-count) )]
          [else (loop (cdr curr-xs) even-sum even-count)]
          )
    )
  (loop xs 0 0)
  )
(avg-of-even '(1 2 3 4 5 6)) ; 12 / 3 = 4

; imperative style/vector
(define (avg-of-even-v2 vect)
  (let ((n (- (vector-length vect)1)))

    (define (helper i sum count)
      (cond [(> i n) (/ sum count)]
            [(even? (vector-ref vect i)) (helper (+ i 1)
                                                 (+ (vector-ref vect i) sum)
                                                 (+ 1 count)) ]
            [else (helper (+ i 1) sum count)]
            )
      )
    (helper 0 0 0)

    )
  )
(avg-of-even-v2 (vector 1 2 3 4 5 6))

; ===================================
; WORD BUILDER

; functional/list style
(define (word-builder-v1 xs)
  ; inner loop/helper
  ; inserts at end, except if x = car xs
  (define (insert-at-end-to-each x xs)
    (cond [(null? xs) '()]
          [(equal? x (car xs)) (insert-at-end-to-each x (cdr xs)) ] ; skip
          [else (let* ((str0 (symbol->string (car xs)))
                       (str1 (symbol->string x))
                       (combined (string-append str1 str0))
                       )
                  (cons combined
                        (insert-at-end-to-each x (cdr xs)))
                  )]
          )
    )
  
  ; outer loop
  (define (loop curr-xs result)
    (cond [(null? curr-xs) result]
          [else (loop (cdr curr-xs)
                      (append (insert-at-end-to-each (car curr-xs) xs)
                              result)) ]
          )
    )
  (insert-at-end-to-each 'a '(a b c d)) ; '(ab ac ad)
  (loop xs '())
  
  )
(word-builder-v1 '(a b c d))


; imperative/vector
(define (word-builder-v2 vect)
  (let* ((n (- (vector-length vect) 1))
         (len (vector-length vect))
         (total-len (* len (- len 1)))
         (result-vect (make-vector total-len)))

    ; outer loop: i
    ; inner loop: j
    (define (loop i j k)
      (cond [(> i n) result-vect] ;done
            [(> j n) (loop (+ i 1) 0 k) ] ;move to next row
            [else (let* ((curr-row (vector-ref vect i))
                         (curr-col (vector-ref vect j))
                         (appended-val (string-append (symbol->string curr-row)
                                                      (symbol->string curr-col)))
                         )
                    ; append to each
                    (if (= i j)
                        (loop i (+ j 1) k)
                        (begin (vector-set! result-vect k appended-val)
                               (loop i (+ j 1) (+ k 1)))
                        )
                    )])
      )
    (loop 0 0 0)    
    
    )
  )
(word-builder-v2 (vector 'a 'b 'c 'd))

; ================================================

; ARRAY SAMPle
(define (array-sample vect)
  (let ((n (- (vector-length vect) 1)))
    (vector (vector-ref vect 0)
            (vector-ref vect (quotient n 2))
            (vector-ref vect n))
    )
  )
(array-sample (vector 1 2 3 4 5 6 7 8 9 10))


; ================================================

; INVENTORY
; not O(n^2) -> because outer loop runs n time
; but inner loop runs only up to 5 constant time
; 5N -> O(n)

; ================================================

; COUNT ONES
; not O(n^2)
; open box 1 -> pick up one by one. count and put aside
; open box 2, repeat until every box isempty
; total candies = exactly n (all items flatenned)

(define (count-ones vect)
  (let ((n (- (vector-length vect) 1) ))

    #|
    WITH FOR/FOLD
    ; outer loop
    (for*/fold ((count 0))
               ((row vect)
                (item row))
      ; inner loop
      (if (= item 1)
          (+ count 1)
          count
          )
      )
    |#

    ;i = row
    ;j = col
    (define (loop i j count)
      (cond [(> i n) count]
            [(> j (- (vector-length (vector-ref vect i)) 1) ) (loop (+ i 1) 0 count)]
            [else (let* ((curr-row (vector-ref vect i))
                         (curr-val (vector-ref curr-row j))
                         )
                    (if (= curr-val 1)
                        (loop i (+ j 1) (+ count 1))
                        (loop i (+ j 1) count)
                        )
                    )]
            )
      )
    (loop 0 0 0)
    
    )
  )
(count-ones (vector (vector 0 1 1 1 0)
                    (vector 0 1 0 1 0 1)
                    (vector 1 0)))


; ==========================================

;PALINDROME CHCECKER

; functional style
; lets just use symbol instead of string simpler
; list-of-symbol -> boolean
(define (palindrome-v1 xs)
  (equal? xs (reverse xs))
  )
(palindrome-v1 '(r a c e c a r)) ;#t
(palindrome-v1 '(h e l l o))


; imperative style
; vector -> boolean
(define (palindrome-v2 vect)
  (let ((n (- (vector-length vect) 1)))


    ;manual vector recursion
    (define (loop left-index right-index)
      (cond [(>= left-index right-index) #t]
            [else (let ((left-val (vector-ref vect left-index))
                        (right-val (vector-ref vect right-index))
                        )
                    (if (equal? left-val right-val)
                        (loop (+ left-index 1) (- right-index 1))
                        #f
                        )
                    )]
            )
      )
    (loop 0 n)


    
    )
  )
(palindrome-v2 (vector 'r 'a 'c 'e 'c 'a 'r))
(palindrome-v2 (vector 'h 'e 'l 'l 'o))

; ==========================================

; GET ALL PRODUCTS

; functional/list style
(define (get-all-products-v1 xs)
  ; 1 -> 2 3 4 5
  ; 2 -> 3 4 5
  ; 3 -> 4 5
  ; 4 -> 5
  ; helper:: number list-of-number -> list-of-number
  ; wait i dont need custo mrecursive just use map
  (define (helper xs)
    (cond [(null? xs) '()]
          [else (let* ((rest (cdr xs))
                       (rest-multiplied (map (λ (x) (* (car xs) x)) rest) ))
                  (append rest-multiplied (helper (cdr xs)))
                  )]
          )
    )
  (helper '(1 2 3 4 5)) ;should return '(6 8 10)
  
  )
(get-all-products-v1 '(1 2 3 4 5)) ;returns list of unique product pairs

; imperative/vector style
(define (get-all-products-v2 vect)
  (let ((n (- (vector-length vect) 1)))

    #|
    ;manual recursion
    (define (loop i j result)
      (cond [(> i n) (list->vector (reverse result))] ;outer loop
            [(> j n) (loop (+ i 1) (+ i 2) result)]
            [else (let ((num-outer (vector-ref vect i))
                        (num-inner (vector-ref vect j)))
                    (loop i (+ j 1) (cons (* num-outer num-inner) result))
                    )]
            )
      )
    (loop 0 1 '())
    |#
    
   
    ;with for/fold
    (for*/fold ((products '()))
               ((i (in-range 0 (vector-length vect))) (j (in-range (+ i 1) (vector-length vect))))
      (cons (* (vector-ref vect i) (vector-ref vect j)) products)
      )
    
    )
  )
(get-all-products-v2 (vector 1 2 3 4 5))