#lang racket

;exercise 2.29

; A BinaryMobile is (make-mobile Branch Branch)
; A Branch is (make-branch Number Structure)
; A Structure is either:
;   - Number          ; a simple weight
;   - BinaryMobile    ; a nested mobile

; Number Structure -> Branch
(define (make-branch length structure)
  (list length structure)
  )

; Branch Branch -> BinaryMobile
(define (make-mobile left right) (list left right) )

;Example Variables
(define branch1 (make-branch 2 4))
(define branch2 (make-branch 4 2))
(define mobile1 (make-mobile branch1 branch2) )
(define branch3 (make-branch 3 mobile1))


; BinaryMobile -> Branch
(define (left-branch mobile)
  (car mobile)
  )

; BinaryMobile -> Branch
(define (right-branch mobile)
  (cadr mobile)
  )
;(right-branch mobile1)

; Branch -> Number
(define (branch-length branch)
  (car branch)
  )

; Branch -> Structure
(define (branch-structure branch)
 (cadr branch)
  )
;(branch-structure branch3) ; not a weight but another binarymobile
;(branch-structure branch2) ; branch weight = 20

;Mobile -> Number
; calculates the total weight of a mobile
; calls branch-weight for each branch
(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile)) (branch-weight (right-branch mobile)) )
  )

; Branch -> Number
; Calculates the weight of a single branch (branch structure Number) of a given branch
; Might call total weight if branch structure is a BinaryMobile
(define (branch-weight branch)
  (cond [(number? (branch-structure branch)) (branch-structure branch)] ;a leaf, return the structure of the branch
        [else (total-weight (branch-structure branch)) ] ;else its a mobile, calculate the total weight
        )
  )
;(branch-weight branch1)
;(branch-weight branch3)
;(total-weight mobile1)

;Branch -> Number
; computes the torque of a branch
; torque = length * weight
(define (branch-torque branch)
   (* (branch-length branch) (branch-weight branch)) 
  )
(branch-torque branch1)
(branch-torque branch3)

; Mobile -> Boolean
; checks if a given mobile is balanced
; balanced means equal torque on left & right branch
(define (is-balanced? mobile)
  (and (equal? (branch-torque (left-branch mobile)) (branch-torque (right-branch mobile)))
       (or (number? (branch-structure (left-branch mobile))) (is-balanced? (branch-structure (left-branch mobile))))
       (or (number? (branch-structure (right-branch mobile))) (is-balanced? (branch-structure (right-branch mobile)))))
  )
(is-balanced? mobile1)
(is-balanced? (make-mobile (make-branch 2 4) (make-branch 4 3)))
(is-balanced? (make-mobile (make-branch 2 (make-mobile (make-branch 1 4) (make-branch 1 4)))
             (make-branch 2 (make-mobile (make-branch 1 4) (make-branch 1 4)))))

