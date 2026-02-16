#lang racket

(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (sqr test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b) (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))


(define (accumulate op initial sequence)
  (define (accumulate-helper sequence acc)
    (if (null? sequence)
        acc
        (accumulate-helper (cdr sequence) (op (car sequence) acc))))
  (accumulate-helper sequence initial))



; X Number -> List-of-X
(define (enumerate-interval low high)
  (cond [(> low high) '()]
        [else (cons low (enumerate-interval (add1 low) high)) ])
  )
;(enumerate-interval 2 7)


(define (enumerate-interval.v2 low high)
  (define (iter-interval n acc)
    (cond [(> n high) (reverse acc)] 
          [else (iter-interval (add1 n) (cons n acc) )])
    )
  (iter-interval low '())
  )
;(enumerate-interval.v2 2 7)



(define (my-func i j)
  (map (lambda (i) (map (lambda (j) (list i j) ) (enumerate-interval 1 3) ) ) (enumerate-interval 1 5) )
  )
;(my-func '(1 2 3) '(4 5 6) )

; [X -> List-of-Y] List-of-X -> List-of-Y
(define (flatmap proc seq)
  (accumulate append '() (map proc seq))
  )

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair) ) )
  )

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair) ) )
  )

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum? (flatmap
                           (lambda (i)
                             (map (lambda (j) (list i j))
                                  (enumerate-interval 1 (- i 1))))
                           (enumerate-interval 1 n)))))

(define (remove item l)
  (filter (lambda (x) (not(= x item)) ) l)
  )

;exercise 2.40

(define (unique-pairs n)
  (flatmap (lambda (i) (map (lambda (j) (list i j))
                            (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n))
  )
;(unique-pairs 3)

;exercise 2.41
;procedure to find all ordered triples of distinct positive integers i,j, and k
; less than or equal to a given integer n that sums to a giiven integer s


; Number Number -> List-of-[Number Number Number]
(define (find-ordered-triples n s)
  (filter (lambda (triple) (= (accumulate + 0 triple) s) )
          (flatmap (lambda (i)
                     (flatmap (lambda (j) (map (lambda (k) (list i j k) )
                                               (enumerate-interval 1 (- j 1))))
                              (enumerate-interval 1 (- i 1))))
                   (enumerate-interval 1 n))
          )

    

  )
;(find-ordered-triples 5 10)

;An empty chess board
; List-of-[List-of Number Number]
(define empty-board '())

; Number Number List-of-[List-of Number Number] -> List-of-[List-of Number Number]
(define (adjoin-position row col l)
  (cons (list row col) l )
  )
;(adjoin-position 3 3 '((1 1) (2 2)))

; Number List-of-[List-of Number Number] -> Boolean
; checks if placing a queen in column `col` (already added to pos)
; is safe with respect to all other queens in pos
; pos is a list of (Row Column)
(define (safe? k pos)
  (let* ((new-queen-pos (first pos))
         (new-queen-col k)
         (new-queen-row (first new-queen-pos))
         (old-queens-pos (rest pos))
         )
    (not (ormap (lambda (old-queen) 
                  (let ((old-queen-col (second old-queen))
                        (old-queen-row (first old-queen))
                        )
                    (or (= new-queen-row old-queen-row)
                        (= (abs (- new-queen-row old-queen-row))
                           (abs (- new-queen-col old-queen-col))))
                    )
                  )
                old-queens-pos))
    )
  )
(safe? 4 '((3 4) (1 3) (4 2) (2 1))) ; should now return #f
(safe? 4 '((2 4) (4 3) (1 2) (3 1))) ; should still return #t



; Number -> List-of-[List-of Row Column]
; Given board-size n, return all sequences of positions [(r1 c1), (r2 c2), ..., (rn cn)]
; Each sequence represents a safe placement of queens from column 1 to n
(define (queens board-size)
  ; returns the sequence of all ways to place queen
  ; in the first k column of the board
  ; Number -> List-of-???
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position
                    new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1)))

         )))
  (queen-cols board-size))


(flatmap
 (lambda (rest-of-queens)
   (map (lambda (new-row)
          (adjoin-position new-row k rest-of-queens))
        (enumerate-interval 1 board-size)))
 (queen-cols (- k 1)))


(flatmap
 (lambda (new-row)
   (map (lambda (rest-of-queens)
          (adjoin-position new-row k rest-of-queens))
        (queen-cols (- k 1))))
 (enumerate-interval 1 board-size))

;it seems louis is inputting new row inside flatmap's (outer loop) lambda insted of the restof the queens
; so it cheks for each row in interval 1 - board size
; then it maps (inner loop) each of those row a function that takes the rest of the queen's list
; and the map has an interval queen cols (k - 1) which is recursive, so the inner loop will probably branch and take forever?
