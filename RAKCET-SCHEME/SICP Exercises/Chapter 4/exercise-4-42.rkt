#lang racket

; exercise 4.42 liar's puzzle

; betty:  i was third, kitty was second
; ethel: i was 1st, joan was 2nd
; joan: i was third, ethel was last
; kitty: i was second, mary was fourth
; mary: i was fourth, betty was 1st

; a Ranking is a pair (cons String Number)
; '(betty 3)

; A Solution is a unique list-of-pair
; '((betty 3) (mary 2) (kitty 1) ...)

; A Permutation is a list-of-number
; example: '(5 7 8 1 2)

(define (find-ranking)
  (let ((betty '(1 2 3 4 5))
        (ethel '(1 2 3 4 5))
        (joan '(1 2 3 4 5))
        (kitty '(1 2 3 4 5))
        (mary '(1 2 3 4 5))
        (names '(betty ethel joan kitty mary)))


    ; Exclusive for given a and b
    ; X Y -> Boolean
    (define (xor a b)
      (or (and a (not b) )
          (and (not a) b )
          )
      )    

    ; Checks if a permutation is valid
    (define (is-valid? perm)
      (let ((betty (list-ref perm 0))
            (ethel (list-ref perm 1))
            (joan (list-ref perm 2))
            (kitty (list-ref perm 3))
            (mary (list-ref perm 4))
            )
        
        ; assign each girl a position
        (and (xor (= betty 3) (= kitty 2))
             (xor (= ethel 1) (= joan 2))
             (xor (= joan 3) (= ethel 5))
             (xor (= kitty 2) (= mary 4))
             (xor (= mary 4) (= betty 1)))


        ; check each girl's 2 statmeents
        ; for each girl only one sttement is true
        ; keep the perm if it passes for all girls
        )
      )

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

    (define all-perms (generate-permutation '(1 2 3 4 5) ))

    (define (permutation->solution perm)
      (map list '(betty ethel joan kitty mary) perm))

    (define valid-perms (filter is-valid? all-perms))
    
    (if (null? valid-perms)
        '()
        (permutation->solution (car valid-perms)))
    
    )
  )
(find-ranking)