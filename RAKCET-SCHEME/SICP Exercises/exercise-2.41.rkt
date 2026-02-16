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
(find-ordered-triples 5 10)