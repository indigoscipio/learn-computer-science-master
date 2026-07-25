#lang racket

;CHAPTER 3

; a Result is a (list merged-list inversion-count)
; where merged-list is a list of numbers
; and inversion count is a number

; list-of-x list-of-y -> Result
(define (merge xs ys)
  (cond [(null? xs) (list ys 0)]
        [(null? ys) (list xs 0)]
        [else (if (< (car xs) (car ys))
                  (let* ((rec-result (merge (cdr xs) ys))
                         (res-merge (car rec-result))
                         (res-count (cadr rec-result))
                         )
                    (list (cons (car xs) res-merge) res-count) ;put in front
                    )
                  (let* ((rec-result (merge xs (cdr ys)))
                         (res-merge (car rec-result))
                         (res-count (cadr rec-result)))
                    (list (cons (car ys) res-merge) (+ res-count (length xs)) )
                    )
                  )]
        )
  )
(merge '(1 4 6) '(2 3 7))


(define (merge-tail xs ys)
  ; on each iteration, build the list
  (define (merge-tail-helper lst0 lst1 lst-acc count-acc)
    ;iknow we need to reverse lst-acc at end butfornow letskeepthis
    (cond [(null? lst0) (list (append (reverse lst-acc) lst1 ) count-acc)]
          [(null? lst1) (list (append (reverse lst-acc) lst0 ) count-acc)]
          [else (if (> (car lst0) (car lst1))
                    (merge-tail-helper lst0
                                       (cdr lst1)
                                       (cons (car lst1) lst-acc)
                                       (+ (length lst0) count-acc)
                                       ) ;lst0 out of order
                    (merge-tail-helper (cdr lst0)
                                       lst1
                                       (cons (car lst0) lst-acc)
                                       count-acc
                                       ) ;lst0 in correct order
                    )]
          )
    )
  (merge-tail-helper xs ys '() 0)
  )
(merge-tail '(1 4 6) '(2 3 7))
(merge-tail '(1) '(4 5 6))

; given a list of length n, splits the list into two with length n/2
; list-of-x -> listof-list-of-x
(define (split xs)
  (let* ((n (quotient (length xs) 2))
         (first-half (take xs n) )
         (second-half (drop xs n))
         )
    (list first-half second-half)
    )
  )

; MERGE SORT
; list-of-x -> Result
(define (mergesort xs)
  (let* ((split-xs (split xs))
         (first-half (car split-xs))
         (second-half (cadr split-xs)))
    (cond [(null? xs) (list '() 0)]
          [(null? (cdr xs)) (list xs 0)] ; only one item
          [else (let* ((first-res (mergesort first-half))
                       (first-sorted (car first-res))
                       (first-count (cadr first-res))
                       (second-res (mergesort second-half))
                       (second-sorted (car second-res))
                       (second-count (cadr second-res))
                       (merge-res (merge first-sorted second-sorted))
                       (merge-sorted (car merge-res))
                       (merge-count (cadr merge-res))
                       )
                  (list merge-sorted
                        (+ merge-count first-count second-count)))])
    )
  )
(mergesort '(3 1 5 0 8 99))

; v2, with mergesort
; n log n implementation
(define (count-inversions-v2 xs)
  0
  )
(count-inversions-v2 '(1 3 5 2 4 6))

; helper
; number list-of-number -> number
(define (count-inversion x xs)
  (cond [(null? xs) 0]
        [(> x (car xs)) (+ 1 (count-inversion x (cdr xs)))] ;out of order
        [else (count-inversion x (cdr xs))]
        )
  )
(count-inversion 3 '(1 2))

; INVERSIONS
; how out of order is an array?
; normal way
(define (count-inversions xs)
  (cond [(null? xs) 0]
        [else (let ((fst (car xs))
                    (rest (cdr xs))
                    )
                (+ (count-inversion fst rest) (count-inversions rest) )
                )]
        )
  )
(count-inversions '(3 1 2)) ; i0 vs 1, i0 vs 2, 2 inversions
(count-inversions '(1 3 5 2 4 6)) ;???
(count-inversions '(1 2 3)) ; 0 inversions

#|
Quiz 3.1
What ist he largest posible inversions of a 6 element array can have?

answer:
ok so we have lets day
6 5 4 3 2 1 which is completely sorted in opposite way

let x be the curr number and i is the counter for the inversion
so n = 6, x = 6, i = 0
first check 6
(6,5) -> +1
(6,4) -> +1
(6,3) -> +1
(6,2) -> +1
(6,1) -> +1
total = 5

next x = 5, i = 5
(5,6) -> 0
(5,4) -> +1
(5,3) -> +1
(5,2) -> +1
(5,1) -> +1
total inversion = 4

so its like the sum
5+4+3+2+1 -> 15

|#

#|
QUIZ 3.2
SupposetheinputarrayAhasnosplit inversions.What istherelationshipbetweenthesortedsubarraysCandD?

a)ChasthesmallestelementofA,Dthesecond-smallest,
Cthethird-smallest,andsoon.
b)AllelementsofCarelessthanallelementsofD.
c)AllelementsofCaregreaterthanallelementsofD.
d)Thereisnotenoughinformationtoanswerthisques
tion.

answer:
ok so input array A has no split inversion
we wanna know relationship between sorted subarray c and d

if c and d is already sorted
lets say c = {4 6 8}
d = {1 2 3}

4 < 1? false
so thatmeans we found inversion of length d

wht sxactly here is array A? notsure
zero split inversion =
every single element in C is smaller than every single element in D

an inversion happens when:
LEFT ELEMENT > RIGHT ELEMENT

|#

; =======================================

; STRASSE'S MATRIX MULTIPLICATION

; matrix x (reicpe) = {a b | c d}
; matrix y (nutrient) = {e f | g h}

; matrix x . matrix y = (r1.c1 r1.c2 | r2.c1 r2.c2)
; matrix x . matrix y = (ae+bg ce+dg | af+bh cf+dh)

; a Matrix is a (listof (listof Number))
; represented as a list of rows

(define matrix0 '((1 2) (3 4)))
(define matrix1 '((5 6) (7 8)))

; given two lists of equal length
; reutrns its dot product
; list-of-number list-of-number -> number
(define (dot-product xs ys)
  (foldr + 0 (map * xs ys))
  )
(display 'dot-product)(newline)
(dot-product '(3 2) '(2 4)) ; 14

; give a matrix, transposes it
; Matrix -> Matrix
(define (transpose mx)
  (cond [(null? mx) '()]
        [(null? (car mx)) '()]
        [else (cons (map car mx) (transpose (map cdr mx)) ) ]
        )
  )
(display 'transpose)(newline)
(transpose '((e f) (g h))) ; '((e g)(f h))
(transpose '((a b c) (d e f))) ;'((a d) (b e) (c f))

; matrix matrix -> matrix
; n^3 implmenetation
(define (matrix-mult x y)
  (let ((y-trans (transpose y)))
    (map (λ (x-row)
           (map (λ (y-col) (dot-product x-row y-col) ) y-trans) ) x)
    )
  )
(display 'matrix-mult)(newline)
(matrix-mult matrix0 matrix1)
;'((1 2) (3 4)) mults '((5 6) (7 8))

#|
QUIZ 3.3

Whatistheasymptoticrunningtimeofthestraightforward
algorithmformatrixmultiplication, asa functionof the
matrixdimensionn?Assumethattheadditionormultipli
cationoftwomatrixentriesisaconstant-timeoperation.

a)O(n log n)
b)O(n^2)
c)O(n^3)
d)O(n^4)

answer:
this is n^3 right? coz it has to tierate
total cells = n . n = n^2
for each cell do the operation which is n?

|#

; given a matrix, splits into 4 quadrants
; Matrix -> List-of-Matrix
(define (split-matrix mx)
  ;q1 : first top half
  ;q2 : right top half
  ;q3 : bottom left half
  ;q4 : botom right half
  (let* ((n (length (car mx)))
        (n/2 (quotient n 2))
        (top-rows (take mx n/2))
        (bottom-rows (drop mx n/2))
        (q1 (map (λ (r) (take r n/2)) (take top-rows n/2)))
        (q2 (map (λ (r) (drop r n/2)) (take top-rows n/2)))
        (q3 (map (λ (r) (take r n/2)) (take bottom-rows n/2)))
        (q4 (map (λ (r) (drop r n/2)) (take bottom-rows n/2)))
        )
    (list q1 q2 q3 q4)
    )
  )
(split-matrix '((1 2) (3 4))) ;'((1)(2)(3)(4))
(split-matrix '((1 2 3 4)
                (5 6 7 8)
                (9 10 11 12)
                (13 14 15 16))) ;((1 2 5 6) (3 4 7 8) (9 10 13 14) (11 12 15 16))

; given two matrices of equal size, performs matrix addiiton
(define (matrix-add mx1 mx2)
  (map (λ (r1 r2)
         (map (λ (c1 c2) (+ c1 c2) ) r1 r2) ) mx1 mx2)
  )
(matrix-add '((1 2) (3 4)) '((5 6) (7 8)))

(define (matrix-sub mx1 mx2)
  (map (λ (r1 r2)
         (map (λ (c1 c2) (- c1 c2)) r1 r2)) mx1 mx2))

; given a 4quadrant matrices, stiches them back together into one full matrix
; list-of-matrix -> matrix
(define (recombine-matrix mx)
  (let* ((q1 (car mx))
        (q2 (cadr mx))
        (q3 (caddr mx))
        (q4 (cadddr mx))
        (top-q (map append q1 q2))
        (bottom-q (map append q3 q4))
        )
    (append top-q bottom-q)
    )
  )
(recombine-matrix '(((1)) ((2)) ((3)) ((4))))

; recmatmult:: matrix matrix -> matrix
; divide and conquer approach, still n^3
; matrix x . matrix y = (ae+bg ce+dg | af+bh cf+dh)
(define (recmatmult x y)
  (cond [(or (null? (cdr x)) (null? (cdr y))) (list (* (car (car x)) (car (car y))))]
        [else (let* ((new-x (split-matrix x))
                     (new-y (split-matrix y))
                     (n 4)
                     (A (car new-x))
                     (B (cadr new-x))
                     (C (caddr new-x))
                     (D (cadddr new-x))
                     (E (car new-y))
                     (F (cadr new-y))
                     (G (caddr new-y))
                     (H (cadddr new-y))
                     (AE (recmatmult A E))
                     (BG (recmatmult B G))
                     (AF (recmatmult A F))
                     (BH (recmatmult B H))
                     (CE (recmatmult C E))
                     (DG (recmatmult D G))
                     (CF (recmatmult C F))
                     (DH (recmatmult D H))
                     (Q1 (matrix-add (list AE) (list BG)))
                     (Q2 (matrix-add (list AF) (list BH)))
                     (Q3 (matrix-add (list CE) (list DG)))
                     (Q4 (matrix-add (list CF) (list DH)))
                     )
                (recombine-matrix (list Q1 Q2 Q3 Q4))
                )]
        )
  )
(recmatmult matrix0 matrix1)

; recmatmult:: matrix matrix -> matrix
; divide and conquer approach, still n^3
; matrix x . matrix y = (ae+bg ce+dg | af+bh cf+dh)
;; --- Strassen's Matrix Multiplication ---
(define (strassen x y)
  (cond [(or (null? (cdr x)) (null? (cdr y)))
         ;; Base Case: Returns a proper 2D matrix '((val))
         (list (list (* (car (car x)) (car (car y)))))]
        [else
         (let* ((new-x (split-matrix x))
                (new-y (split-matrix y))
                (A (car new-x))
                (B (cadr new-x))
                (C (caddr new-x))
                (D (cadddr new-x))
                (E (car new-y))
                (F (cadr new-y))
                (G (caddr new-y))
                (H (cadddr new-y))
                
                ;; 1. Seven Strassen Products
                (P1 (strassen A (matrix-sub F H)))
                (P2 (strassen (matrix-add A B) H))
                (P3 (strassen (matrix-add C D) E))
                (P4 (strassen D (matrix-sub G E)))
                (P5 (strassen (matrix-add A D) (matrix-add E H)))
                (P6 (strassen (matrix-sub B D) (matrix-add G H)))
                (P7 (strassen (matrix-sub A C) (matrix-add E F)))
                
                ;; 2. Reconstruct the Four Quadrants
                ;; Q1 = P5 + P4 - P2 + P6
                (Q1 (matrix-add (matrix-sub (matrix-add P5 P4) P2) P6))
                
                ;; Q2 = P1 + P2
                (Q2 (matrix-add P1 P2))
                
                ;; Q3 = P3 + P4
                (Q3 (matrix-add P3 P4))
                
                ;; Q4 = P1 + P5 - P3 - P7
                (Q4 (matrix-sub (matrix-add P1 P5) (matrix-add P3 P7))))
           
           ;; 3. Combine into a single matrix
           (recombine-matrix (list Q1 Q2 Q3 Q4)))]))



#|
CLOSEST PAIR
brute force -> n^2
1d -> sort first


|#

; a Posn is a struct - Number Number
; that stores location x,y pos
(struct posn (x y) #:transparent)
(define p1 (posn 1 1))
(define p2 (posn 1 100))
(define p3 (posn 20 2))
(define p4 (posn 999 999))
(define p5 (posn 0 0))
(define p6 (posn 78 2))

; Posn Posn -> Number
(define (distance p1 p2)
  (sqrt (+ (sqr (- (posn-x p1) (posn-x p2)))
           (sqr (- (posn-y p1) (posn-y p2))))
        )
  )

; List-of-posns -> Posn
(define (closest-pair xs)
  (let ((x-sorted (sort xs (λ (p1 p2)(< (posn-x p1) (posn-x p2)))) ))

    (define (closest-pair-helper pts)
      (cond [(<= (length pts) 2) (let ((p1 (car pts))
                                       (p2 (cadr pts)))
                                   (distance p1 p2)
                                   )] ;just find the min distance
            [(= (length pts) 3) (let ((p1 (car pts))
                                      (p2 (cadr pts))
                                      (p3 (caddr pts)))
                                  (min (distance p1 p2) (distance p2 p3) (distance p1 p3))
                                  ) ] 
            [else (let* ((k (quotient (length pts) 2))
                         (left (take pts k))
                         (right (drop pts k))
                         (min-left (closest-pair-helper left))
                         (min-right (closest-pair-helper right))
                         (delta (min min-left min-right))
                         (mid-x (posn-x (last left)))
                         (strip (filter (λ (p) (< (abs (- (posn-x p) mid-x)) delta)) pts))
                         (sorted-strip (sort strip (λ (p1 p2) (< (posn-y p1) (posn-y p2))))) 
                         )
                    0
                    )]
            )
      )
    (closest-pair-helper x-sorted)
    )
  )
(closest-pair (list p1 p2 p3 p4 p5 p6))

; 1D case
; list-of-number -> (list number number)
(define (closest-pair-1d xs)
  (let ((sorted-xs (sort xs <)))
    (define (loop lst best-dist best-x best-y)
      (cond [(null? (cdr lst))(cons best-x best-y)] ;1 item left
            [else (let* ((fst (car lst))
                        (sec (cadr lst))
                        (curr-dist (abs (- fst sec)))
                        (new-winner? (< curr-dist best-dist)))
                    (if new-winner?
                        (loop (cdr lst) curr-dist fst sec); update
                        (loop (cdr lst) best-dist best-x best-y) ; keep searching
                        )
                    
                    ) ]
            )
      )
    (loop sorted-xs (abs (- (car xs) (cadr xs))) (car xs) (cadr xs))

    )
  )
(closest-pair-1d '(1 1 3 5 6 7 8 10 16 99))

; DIVIDE CONQUER
#|
left pair, right pair, split pair
split pair - pair where one point on the left and one point on the right
middle is the wall
|#
(define (closest-pair-v2 pts)
  (let ((x-sorted (sort pts (λ (p1 p2)(< (posn-x p1) (posn-x p2)))))
        (y-sorted (sort pts (λ (p1 p2)(< (posn-y p1) (posn-y p2)))))
        )

    
    (define (sorted-pair-helper xs ys)
      (cond
            [(<= (length xs) 3) 0]
            [else (let* ((k (quotient (length xs) 2) ) ;xs ys same length
                         (xs-left (take xs k))
                         (xs-right (drop xs k))
                         (mid-x (posn-x (last xs-left)))
                         (ys-left (filter (λ (p) (<= (posn-x p) mid-x)) ys) )
                         (ys-right (filter (λ (p) (> (posn-x p) mid-x)) ys))
                         (min-left (sorted-pair-helper xs-left ys-left))
                         (min-right (sorted-pair-helper xs-right ys-right))
                         (delta (min min-left min-right))
                         (strip (filter (λ (p) (< (abs (- (posn-x p) mid-x)) delta)) ys)) 
                         )

                    ;; 1. Check one point against the next 7 neighbors (or until y-dist >= best)
                    (define (check-one p rest k best)
                      (cond
                        [(or (null? rest) (>= k 7)) best]
                        [else
                         (let* ((q (car rest))
                                (dy (- (posn-y q) (posn-y p))))
                           (if (>= dy best)
                               best ; early exit: all remaining points are even further away in y!
                               (let ((d (distance p q)))
                                 (check-one p (cdr rest) (+ k 1) (min best d)))))]))

                    ;; 2. Walk down the strip list
                    (define (check-neighbour xs best)
                      (cond
                        [(null? xs) best]
                        [else
                         (let ((new-best (check-one (car xs) (cdr xs) 0 best)))
                           (check-neighbour (cdr xs) new-best))]))

                    (check-neighbour strip delta)
                    
                    )]
            )
      )
    (sorted-pair-helper x-sorted y-sorted)
    
    )
  )
(closest-pair-v2 (list p1 p2 p3 p4 p5 p6))

#|
QUIZ 3.4

SupposethatwecorrectlyimplementtheClosestSplitPair
subroutineinO(n)time.Whatwillbetheoverall running
timeoftheClosestPairalgorithm? (Choosethesmallest
upperboundthatapplies.)

a. O(n)
b)O(n log n)
c)O(n(logn)^2)
d)O(n^2)

answer:

T(n) = a . T(n/b) + f(n)
a -> no. of recursvie calls
n/b -> smaller subproblem size
f(n) -> work done outside recursive

recursive calls = 2
subproblem size -> n/2 (half)
fn = O(n)

T(n) = 2T(n/2) + O(n)
log2 n level . n work = n log n

|#


#|
Problem 3.1
Problem3.1Considerthefollowingpseudocodeforcalculatingab,
whereaandbarepositiveintegers:1

FastPower
Input: positiveintegersaandb.
Output: ab.
if b=1then
returna
else
c:=b·b
ans:=FastPower(c,bb/2c)
if bisoddthen
returna·ans
else
returnans

Assumeforthisproblemthateachmultiplicationanddivisioncanbe
performedinconstanttime.What istheasymptoticrunningtimeof
thisalgorithm,asafunctionofb?

a. big theta(log b)
b) big theta(sqrt b)
c) big theta(b)
d. big theta(b log b)

answer:
letm e analyze
ok let me just try to implemen this quickly

|#

; its hard to implement imperative algorithm into functional
; notsure if this is correct
(define (fastpow a b)
  (cond [(= b 1) a]
        [else (let* ((c (* b b))
                     (ans (fastpow c (floor (/ b 2)))))
                (if (odd? b)
                    (* a ans)
                    ans
                    )
                )]
        )
  )
(fastpow 2 5) ; 2^5 = 32

#|
so it seems
each iteration needs ans which takes 1 recursive call to iteslef
which depends on c and b, and each of that divides b / 2
since calculating c is constant time and rest is pretty much ocnstatn time

so it hink its log b??
|#


; ================================

#|
CHALLENGE PROBLEMS
problem 3.2
You are given a unimodal array of n distinct elements,
meaning that its entries are in increasing order up until its maximum
element, after which its elements are in decreasing order. Give an
algorithm to compute the maximum element of a unimodal array that
runs in O(logn) time.

answer:
let me understand the question
unimodal array is someting liek '(1 2 3 4 5 3 1)

in regular n you just check one by one and keep track of the increase/decrease
i thnk
so 1 -> 2: +1
2 -> 3: +1
3 -> 4: +1
4 -> 5: +1
5 -> 3: -2, stop. previous one is the max
once you know the number is decrease

but we want this in log n time which means
divide and conquer thing
instead of splitting both half, elimiate one half like binary search


so maybe
- split the list in 2 area: left xs and right xs
- since its already sorted maybe check first item in each sector
- pick middle element aMid and its immediateneightbor aMid + 1
- increasing order: if aMid < aMid+1 -> sorted correctly - go right
- decreasing order: if aMid > aMid+1 -> peak is on the left? (or mid itself)
- values getting smaller as we move LTR
- check if amid-1 (left neighbor) > amid
- check if amid+1 (right neighbor) < amid
- amid must sit in between amid-1 > amid > amid+1
- if amid-1 starts to get fewer then amid, then current amid is the biggest one
- so when amid is greater than both amid-1 and amid+1 it is the absolute peak.

|#

(define (find-max-in-unimodal vect)
  (let ((low 0)
        (high (- (vector-length vect) 1)))
    
    (define (find-max-helper a b)
      (cond [(= a b)] ; base case: 0 search range
            [else (let ((... ...))
                    0
                    )] 
            )
      )
    (find-max-helper low high )
    
    )  
  )
(find-max-in-unimodal #(1 3 5 8 6 4 2))