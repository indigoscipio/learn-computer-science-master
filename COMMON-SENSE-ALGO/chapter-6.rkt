#lang racket

; CHAPTER 6

;INSERTION SORT
; set next one to temporary var
;hold 'temporary variable'

; example: 42713
;1st pass -> hold 1st index in temp var (2)
;compare 4 to temp var (greater, shift it right)
;insert temp var to left of 4 -> 24713

;2nd pass: hold 2nd index in temp var (7)
;compare 4 to temp var -> (less, keep it/dont shift)
;put temp var as it is -> 24713

;3rd pass: hold 3rd index in vemp var (1)
; compare 7 to 1 -> greater, shift it right
; compare 4 to 1 -> greater, shift it right
; compare 2 to 1 -> greater, shift it right
; insert temp var there -> 12473

; 4th pass: hold 4th index (3) in temp var
; copmare 7 to 3 -> greater -> shift 7 right
; compare 4 to 3 -> greater -> shift 4 right
; compare 3 to 2 -> less -> place temp value there -> 12347



;INSERTION SORT
;functional/list style
(define (insertion-sort-v1 lst)

  ; given x and a sorted list xs, inserts to correct position
  ; number -> list-of-number
  (define (insert x xs)
    (cond [(null? xs) (cons x '())]
          [(> (car xs) x) (cons x xs)] ;insert
          [else (cons (car xs) (insert x (cdr xs)))]
          )
    )

  (define (loop xs res)
    (cond [(null? xs )res]
          [else (loop (cdr xs) (insert (car xs) res))])
    )
  (loop lst '())
  
  )
(insertion-sort-v1 '(4 2 7 1 3))


;INSERTION SORT
;imperative style/vector
(define (insertion-sort-v2 vect)
  (let ((n (- (vector-length vect) 1) ))

    ; inner loop
    (define (insert i temp-val v)
      (cond [(or (< i 0)
                 (<= (vector-ref v i) temp-val)) ; use <= for stability/efficiency
             (vector-set! v (+ i 1) temp-val)] ;beyond boundary
            [else (begin (vector-set! v (+ i 1) (vector-ref v i))
                         (insert (- i 1) temp-val v))] ; shift element to right, step left
            )
      )    
    
    ; outer loop
    (define (loop i v)
      (cond [(> i n) v] ;base case
            [else (let* ((i-1 (- i 1))
                         (i-1val (vector-ref v i-1))
                         (temp-val (vector-ref v i)))
                    (begin
                      (insert i-1 temp-val v)
                      (loop (+ i 1) v))
                    )]
            )
      )
    (loop 1 vect)
    
    )
  )
(insertion-sort-v2 (vector 4 2 7 1 3))

; =========================

#|

INSERTION SORT EFFICIENCY
pass through (outer loop) -> n-1 times

worst case: [5,4,3,2,1]
temp-val -> 4
4 vs 5 -> 1 comp
shift [4,5,3,2,1]
1 compare, 1 shift

next temp val -> 3
compare 3 vs 5 -> shift
compare 3 vs 4 -> shift
2 compare, 2 shift

continue tilll the end

1. removal -> n-1
2. compariosn -> sum 1 + 2 + 3 ... n-1 -> n(n-1)/2
3. shifts -> n^2/2 shifts
4. insersions -> n-1

total = n^2 + 2n - 2

BEST CASE
vs selection sort -> wins
selection sort doesn't have 'end early' trigget


|#


#|
INSERTION VS SELECTION
- insertion: sliding window
anything below the temp val index is guaranteed to be sorted
divides into 2 region, sorted and unsorted

- selection: find mind -> swap
scans eveyrthing find min then swap
less efficient

|#

;======================================

;intersection, functional style
; not sure how to use break here? is that even psosible
(define (intersection lst1 lst2)
  ; notsure what member cost,
  ; sinceitchecks eachony i assume its n?
  (define (loop xs ys res)
    (cond [(null? xs) res]
          [(member (car xs) ys) (loop (cdr xs) ys (cons (car xs) res)) ]
          [else (loop (cdr xs) ys res)]
          )
    )
  (loop lst1 lst2 '())
  
  )
(intersection '(2 8 1) '(5 8 3))


; vector number -> boolean
(define (vector-contains? v item)
  (let ((start-index 0)
        (n (- (vector-length v) 1)))
      
    (define (helper i)
      (cond [(> i n) #f]
            [(equal? (vector-ref v i) item) #t]
            [else (helper (+ i 1))]
            )
      )
    (helper start-index)
      
    )
  )

; intersection imperative style
; same howi  use break thing here? or doesitnot matter
(define (intersection-v2 v1 v2)
  (let ((start-index 0)
        (n (- (vector-length v1) 1)))
    ; fix v1 -> for each x in v1, call vector-contains? v2 item
    (define (helper i v acc)
      (cond [(> i n) (list->vector acc)]
            [else (let ((curr-v1-val (vector-ref v i)))
                    (if (vector-contains? v2 curr-v1-val)
                        (helper (+ i 1) v (cons curr-v1-val acc)); put in acc
                        (helper (+ i 1) v acc); skip
                        )
                    )]
            )
      )
    (helper start-index v1 '())
    )
  )
(intersection-v2 (vector 2 8 1) (vector 5 8 3))


#|
EXERCISES

1.  Use Big O notation to describe the efficiency of an algorithm that takes
3N^2 + 2N + 1 steps.

answer: ingoring constant we have n^2 an dn
since n^2 grows faster the on is O(n^2)

_

2. Use Big O notation to describe the efficiency of an algorithm that takes
N + log N steps.

answer: for since N grows faster than log n
worst case time is N, therefore timpe its O(N)

_

3. The following function checks whether an array of numbers contains a
pair of two numbers that add up to 10.

def two_sum(array):
for index_i, i in enumerate(array):
for index_j, j in enumerate(array):
if (index_i != index_j) and (i + j == 10):
return True
return False
What are the best-, average-, and worst-case scenarios? Then, express
the worst-case scenario in terms of Big O notation.

answer:
ok let me analyze this. not very familar with python
we have a function that checks if array of number
contains a pair that sums to 10

question asks for best, average and worst case

so its list-of-numbre -> boolean

outer loop: checks each item in array -> n

inner loop: checks each item in array -> excluding index outer = index inner =>
same, n comparison

so thats n . n = n^2

best case: first 2 item is a pair that already sums to 10
thats just 1 comparison -> O(1)

average case: the pair meet at around halfway
im not sure about the exact math here but
outer loop -> around halfway so thats n/2
inner loop -> also around halfway, n/2 - 1
n/2 . n/2 -> n^2/4 -> still around n^2??

worst case: the pair is found at the 'end' of the array
outer loop -> scans n
inner loop -> scans n-1
so thatslike still n . n = n^2 comparison sp
worst case in big O is O(n^2)

_

4. The following function returns whether or not a capital “X” is present
within a string.

def contains_X(string):
found_X = False
for char in string:
if char == "X":
found_X = True
return found_X

What is this function’s time complexity in terms of Big O notation?
Then, modify the code to improve the algorithm’s efficiency for best- and
average-case scenarios.

answer:
ok so we have a function that checks wheter or not capital character
'X' is present in a string

;;contains_x -> string -> boolean
lets analyze

we only have 1 loop which checks each char in the string
say string = 'hello', for checks each char 'h,e,l,l,o'

then if theres a 'X' -> sets found_x to true
im not sure how for loop works here in python, does it stop when
immediately found? since it has like no explicit break i assume
it will still just continue even after theres an "X"??

then at the end, return found x

best case: 'X' is first char in the string -> O(1)
but here theres no break so keeps checking till the end?

average case -> n/2
worst case -> n

so time complexity is O(n)

for improving algorithm i would say add the break thing?
so just below the found_x=true underheak that
just add break
not sure if thats correct syntax not familiar withpyhotn



_



|#