#lang racket

; SELECTION PROBLEM
; finding specific element in an unsorted list of n numbers

; RSELECT


; chooses the ith smaller element of xs
; normal method -> sort first
; positive number list-of-number -> number
(define (selection i xs)
  (let ((sorted-xs (sort xs <)))
    (list-ref  sorted-xs (- i 1))
    )
  )
(selection 1 '(6 8 9 2)) ; second smallest element -> 6


; THE BARRIER
; n log n -> comparison based sorting worst case

#|
QUIZ 6.1
Supposeweare looking for the5thorder statistic inan
inputarrayof10elements. Supposethatafterpartitioning
thearray,thepivotelementendsupinthethirdposition.
Onwhichsideofthepivotelementshouldwerecurse,and
whatorderstatisticshouldwelookfor?

a)The3rdorderstatisticontheleftsideofthepivot.
b)The2ndorderstatisticontherightsideofthepivot.
c)The5thorderstatisticontherightsideofthepivot.
d)Wemightneedtorecurseonboththe leftandthe
rightsidesofthepivot.

answer:
lets analyze this one by one
im not sure what orderstatistic is so thatslike a list ref thing?
so 5th item in a list

so input array n = 10 elements -> '(1 2 3 4 5 6 7 8 9 10)
and the orderstatistic = 5th -> 5th item = 5 if the list is sorted

after partitioning the array pivot ends up in 3rd pos
so 1 2 | pivot | 4 ... 10
if we wanna look for the 5th then we should definietely pivot to the right side
right? doesnt makesense if we check the 2 since the index is smaller we don
wanna move to smaller order of statistic

maybe just move 1 step to the right? i'm not sure

1. pivot ends at pos 3 -> means 3 elements total that are <= pivot
(pivot itself + 2 elmeents to left)
2. throw those 3 cause the target is on the right
3. elimiate 3 smallest element, look for 5 - 3 = 2rd smallest element in remaining


|#

; partition helper
(define (partition pivot xs)
  (define (partition-helper curr-xs small-xs large-xs)
    (cond [(null? curr-xs) (list small-xs large-xs)]
          [else (let* ((curr-val (car curr-xs)))
                  (if (> curr-val pivot)
                      (partition-helper (cdr curr-xs)
                                        small-xs
                                        (cons curr-val large-xs)) ;put in large
                      (partition-helper (cdr curr-xs)
                                        (cons curr-val small-xs)
                                        large-xs
                                        ) ;put in small
                      )
                  )
                ])
    )
  (partition-helper xs '() '())
  )
(partition 4 '(0 1 2 3 7 8 9)) ; '((0 1 2)(7 8 9)) 

; RESELECT
; pivot index j, target index i
; 1. pick pivot p
; 2. split into 2 region (< and >)
; 3. j=i -> done; j > i -> look left; j < i -> look right

; given an index i and list of numbers xs,
; returns the ith th smallest item within xs
(define (rselect i xs)
  ; lets use random pivot
  (cond [(null? xs) '()]
        [else (let* ((pivot  (list-ref xs (random (length xs))))
                    (partitioned-xs (partition pivot xs))
                    (part-xs-left (car partitioned-xs))
                    (part-xs-right (cadr partitioned-xs))
                    (k (length (car partitioned-xs))) ;pivot is the k-th element
                    )
                (cond [(= k i) pivot]
                      ; look left, throw right
                      [(> k i) (rselect i part-xs-left) ]
                      ; look right, throw all up to k
                      ; i - k = new target rank after the left is disbanded
                      ; person who used to be 7th shorted -> 7-4=3rd
                      [else (rselect (- i k) part-xs-right)]
                      )
                )]
        )
  
  )
(rselect 2 '(6 8 9 2)) ;should return 6
(rselect 3 '(3 8 2 5 1 4 7 6)) ;should return 3

; ==============================================================

;; WORST CASE OF RSELECT
; O(n^2)
; why? every pivot chosen is either the edges (min or max)
; pivot eliminates only 1 on each recursion
; size of the array decreases -> n -> n-1 -> n-2 -> n-2
; sum them all -> n(n-1)/2 -> O(n^2)

; ARITHMETIC VS GEOMETRIC REDUCTION
; Rselect performs geometric reduction
; when you elim a percentage, size is multiplied by fraction < 1.0 each recursion
; n -> 0.75n -> (0.75)(0.75)n -> ...
; which converges t o4N

;whereas arithmetic reduction just does
; n -> n-1 -> n-2 ... ->
; which is sum of arithmetic n(n-1)/2 -> O(n^2)

; PHASE 1 -> DO MAX OF 2n operations
; array shrunks to 3/4 size at most
; shrinks again -> and so on

; ==============================================================

; DSELECT ALGORITHM
; divide into 5 groups, find median of those
; collect those now length n/5 and store into var (C).
; find the median of those n/5 with recursive call to dselect (dSelect C)
; the only difference between rselect and dselect is the pick pivot (median of medians)

(define (dselect i xs)
  0
  )