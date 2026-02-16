#lang racket

#|
(define (require p)
  (if (not p) (amb))
  )

(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))
|#

#|
(define (distinct? items)
      (cond ((null? items) true)
            ((null? (cdr items)) true)
            ((member (car items) (cdr items)) false)
            (else (distinct? (cdr items)))))



(define (multiple-dwelling)
  (let ((baker
         (amb 1 2 3 4 5)) (cooper (amb 1 2 3 4 5))
                          (fletcher (amb 1 2 3 4 5)) (miller (amb 1 2 3 4 5))
                          (smith
                           (amb 1 2 3 4 5)))
    (require
      (distinct? (list baker cooper fletcher miller smith)))
    (require (not (= baker 5)))
    (require (not (= cooper 1)))
    (require (not (= fletcher 5)))
    (require (not (= fletcher 1)))
    (require (> miller cooper))
    (require (not (= (abs (- smith fletcher)) 1)))
    (require (not (= (abs (- fletcher cooper)) 1)))
    (list (list 'baker baker)
          (list 'cooper cooper)
          (list 'fletcher fletcher) (list 'miller miller)
          (list 'smith smith))))
|#


;exercise 4.41

; a Floor is a pair (cons String Number)
; '(baker 3)

; A Solution is a list-of-pair
; '((baker 3) (fletcher 2))

; A Permutation is a list-of-number
; example: '(5 7 8 1 2)

(define (multiple-dwellings)
  (let* ((baker '(1 2 3 4 5))
         (cooper '(1 2 3 4 5))
         (fletcher '(1 2 3 4 5))
         (miller '(1 2 3 4 5))
         (smith '(1 2 3 4 5))
         (tenants '(baker cooper fletcher miller smith))
         )

    ; Permutation -> Boolean
    (define (valid? perm)
      (let ((baker (list-ref perm 0))
            (cooper (list-ref perm 1))
            (fletcher (list-ref perm 2))
            (miller (list-ref perm 3))
            (smith (list-ref perm 4))
            )
        (and (and (not (= fletcher 1))
                  (not (= fletcher 5))
                  )
             (not (= cooper 1))
             (not (= baker 5))
             (> miller cooper)
             (not (= (abs (- smith fletcher)) 1))
             (not (= (abs (- fletcher cooper)) 1))
             )
        ))
      
    

    ; Number List-of-Number -> List-of-Number
    ; removes item x from given list l
    (define (remove-one x l)
      (cond [(empty? l) '()]
            [(= x (car l)) (cdr l)]
            [else (cons (car l) (remove-one x (cdr l))) ]
            )
      )

    ; Inserts number x at all possible position l
    ; Number List-of-Number -> List-of-List-of-Number
    (define (insert-at-every-position x l)
      (cond [(empty? l) (list (list x))]
            [else (let ((first (car l))
                        (rest (cdr l))
                        )
                    (cons (cons x l)
                          (map (lambda (sublist) (cons first sublist)) (insert-at-every-position x rest)) ) 
                    )])
      )

    ; Generate all possible permutation
    ; (List-of-Number) -> (List-of-(List-of-Number))
    (define (generate-permutation l)
      (cond [(empty? l) (list '())]
            [else (let ((first (car l))
                        (rest (cdr l))
                        )
                    (apply append (map (lambda (perm) (insert-at-every-position first perm)) (generate-permutation (cdr l))))
                    )])
      )
    
    (define all-perms (generate-permutation '(1 2 3 4 5)))

    ; Permutation -> Solution
    ; (List-of-Number) -> (List-of-Pair)
    (define filtered-perms (map (lambda (perm) (map cons tenants perm) ) (filter valid? all-perms) ) )

    filtered-perms

    )
  )
(multiple-dwellings)