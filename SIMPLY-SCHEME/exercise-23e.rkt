#lang simply-scheme

#|
23.5
23.5 Write a procedure vector–map that takes two arguments, a function and a vector, and returns a new vector in 
which each box contains the result of applying the function to the corresponding element of the argument vector.


(define (vector-map vect f)
  (let ((new-vect (make-vector (vector-length vect) 0)))
    (define (helper v i)
      (cond [(>= i (vector-length vect) ) 'done]
            [else (let* ((curr-item (vector-ref v i))
                         (mapped-item (f curr-item)))
                    (begin (vector-set! new-vect i mapped-item)
                           (helper v (+ i 1))
                           )
                    )])
      )
    (helper vect 0)
    new-vect
    )
  )
|#



#|
23.6 Write a procedure vector–map! that takes two arguments, a function and a vector, and modifies the argument 
vector by replacing each element with the result of applying the function to that element. Your procedure should return 
the same vector.
|#

; like vecotr-map but mutable
(define (vector-map! vect f)
  (let ((v-length (vector-length vect)))
    (define (helper v i)
      (cond [(< i 0) 'done]
            [else (let* ((curr-item (vector-ref v i))
                        (mapped-item (f curr-item)))
                    (begin (vector-set! v i mapped-item)
                           (helper v (- i 1)))
                    )]
            )
      )
    (helper vect (- v-length  1))
    vect
    )
  )
(vector-map! (vector 1 2 3 4 5) (λ (x) (* x x)))


#|
23.7 Could you write vector–filter? How about vector–filter!? Explain the issues involved.

answer: lets try one by one first
|#

; vector x->boolean -> number
(define (satisfies-pred-count vect pred)
  (define (helper v i)
    (cond [(>= i (vector-length vect)) 0]
          [else (let ((fst (vector-ref vect i)))
                  (if (pred fst)
                      (+ 1 (helper v (+ i 1)))
                      (helper v (+ i 1))
                      )
                  )])
    )
  (helper vect 0)
  )
(satisfies-pred-count (vector 1 2 3 4 5) even?)


(define (vector-filter vect pred)
  (let ((new-vect (make-vector (satisfies-pred-count vect pred) )))
    (define (helper v i j)
      (cond [(>= i (vector-length vect)) 'done]
            [else (let ((fst (vector-ref v i)))
                    (if (pred fst)
                        (begin (vector-set! new-vect j fst)
                               (helper v (+ i 1) (+ j 1))
                               ) ;keep it
                        (helper v (+ i 1) j)
                        )
                    )]
            )
      )
    (helper vect 0 0)
    new-vect
    )
  )
(vector-filter (vector 1 2 3 4 5) even?)

; ok it seems we have to shrink/rebuild the vector everytime the predicate is passed
; which takes alot of time. everytime  we rebuild need to fill it one by one with corect order.
; the index and length is changed and also the ordering
; im also assuming this would be the same case with vector-filter! so it's very difficult
; vector-filter ispossible but vector-filter! is not possible since vector size is set te moment at its birth
; we can't shrink physical memory ofvector

; ====================================================

#|

23.8 Modify the lap procedure to print "Car 34 wins!" when car 34 completes its 200th lap. (A harder but more 
correct modification is to print the message only if no other car has completed 200 laps.)

answer:

|#

; lets focus on getting to print simple winning message first for now
; and simplify total vecs to to 10 and total winning to 3
(define *lap-vector* (make-vector 10 0))
(define *any-winner?* #f)
(define (lap car-number)
  
  (begin (vector-set! *lap-vector* car-number (+ (vector-ref *lap-vector* car-number) 1) )
         (let ((curr-lap (vector-ref *lap-vector* car-number)))
           (if (and (= curr-lap 3) (not *any-winner?*))
               (begin (set! *any-winner?* #t)
                      (se "winner is car: " car-number)
                      )
               curr-lap
               )
           )
         )
  
  )
(lap 2)

; ==============================================

#|
23.9 Write a procedure leader that says which car is in the lead right now


(define (leader vect)
  ; find maximum value of each vector
  ; return that value
  (define (helper v i best-value best-index)
    (cond [(>= i (vector-length vect)) best-index]
          [else (let ((curr-item (vector-ref v i)))
                  ; curr item > best-value: update new value
                  ; otherwise recurse
                  (if (> curr-item best-value)
                      (helper v (+ i 1) curr-item i)
                      (helper v (+ i 1) best-value best-index))
                  )
                ]
          )
    )
  (helper vect 1 (vector-ref vect 0) 0)
  )
(leader (vector 1 2 9 3 4 5 6))
|#


#|
23.10 Why doesn't this solution to Exercise 23.9 work?
(define (leader)
  (leader–helper 0 1))
(define (leader–helper leader index)
  (cond ((= index 100) leader)
        ((> (lap index) (lap leader))
         (leader–helper index (+ index 1)))
        (else (leader–helper leader (+ index 1)))))

answer:
it seems it doesn't take or modify any vector so abit confusing

it initializes leader helper with leader index 0 and starts scanning challenger at index 1

1st case im asuming the length here is 100? so if its finallly scans the last one it returns the leader
im not sure why it uses lap here which increases the count it shuld've been extracting the actual value instead of using lap so i think
theres the mistake
2nd cond if lap is greater than leader make that index the new leader, and increase the index
3rd case no champion found, just increase the index

so the mistakes are
; hardcoding the 100
; using (lap index) when it should've used (vector-ref) to extract the value
; no input vector for the helper

|#


; =======================================================

#|
23.11 In some restaurants, the servers use computer terminals to keep track of what each table has ordered. Every time 
you order more food, the server enters your order into the computer. When you're ready for the check, the computer 
prints your bill.
You're going to write two procedures, order and bill. Order takes a table number and an item as arguments and 
adds the cost of that item to that table's bill. Bill takes a table number as its argument, returns the amount owed by 
that table, and resets the table for the next customers. (Your order procedure can examine a global variable *menu* 
to find the price of each item.)
> (order 3 'potstickers)
> (order 3 'wor–won–ton)
> (order 5 'egg–rolls)
> (order 3 'shin–shin–special–prawns)
> (bill 3)
13.85
> (bill 5)
2.75

answer:
|#

(define *menu* (vector (cons 'food-a 1.00) (cons 'food-b 2.00) (cons 'food-c 3.00)) )
(define *table* (make-vector 5 0)) ;table that holds bill - lets initialize with small table for now

;; takes table num and item as arg, adds cost of that item to that table's bill
(define (order table-num item)
  ; lookup up price of food in *menu*
  (define (lookup v i target)
    (cond [(>= i (vector-length v)) #f] ;not found
          [else (let ((name (car (vector-ref v i)))
                      (price (cdr (vector-ref v i))))
                  (if (equal? name target)
                      price ;add price to the table
                      (lookup v (+ i 1) target)) ;recurse
                  )])
    )

  (let ((result (lookup *menu* 0 item)))
    (if result
        (vector-set! *table* table-num (+ (vector-ref *table* table-num) result))
        #f
        )
    )
  
  )
*table*
(order 0 'food-c)
(order 1 'food-c)
(order 1 'food-c)
(order 1 'food-c)
(order 1 'food-c)
(order 1 'food-c)
*table*

;; takes table number and returns the amount owned by that table,
;; and resets the table for the next customers
(define (bill table-num)
  (let ((total-amount (vector-ref *table* table-num)))
    (begin (vector-set! *table* table-num 0)
           (se "Bill for table " table-num "is" total-amount)      
           )
    )
  )
(bill 1)
*table*

#|
23.12 Rewrite selection sort (from Chapter 15) to sort a vector.

This can be done in a way similar to the procedure for shuffling a deck:
Find the smallest element of the vector and exchange it (using vector–swap!) with the value in 
the first box.

Then find the smallest element not including the first box, and exchange that with the second box, and so 
on. For example, suppose we have a vector of numbers:
# (23 4 18 7 95 60)

Your program should transform the vector through these intermediate stages:
#(4 23 18 7 95 60)   ; exchange 4 with 23
#(4 7 18 23 95 60)   ; exchange 7 with 23
#(4 7 18 23 95 60)   ; exchange 18 with itself
#(4 7 18 23 95 60)   ; exchange 23 with itself
#(4 7 18 23 60 95)   ; exchange 60 with 95

|#

(define sample-vect (vector 1 2 3 4))

;helper swaps i1 with i2
(define (vector-swap! i1 i2 vect)
  (let ((temp (vector-ref vect i1)))
    (vector-set! vect i1 (vector-ref vect i2))
    (vector-set! vect i2 temp)
    )
  )


(define (find-min starting-index vect)
  (define (helper v i min-value min-index)
    (cond [(>= i (vector-length vect)) min-index]
          [else (let ((curr-item (vector-ref v i)))
                  (if (< curr-item min-value)
                      (helper v (+ i 1) curr-item i)
                      (helper v (+ i 1) min-value min-index))
                  )])
    )
  (helper vect (+ starting-index 1) (vector-ref vect starting-index) starting-index)
  
  )
(find-min 0 (vector 1 2 3 4 5)) ;should return 1 (index 0)


(define (selection-sort-vect vect)
  (define (ss-vect-helper v i)
    (cond [(>= i (- (vector-length v) 1) ) v] ;done, return the vector
          [else (let ((smallest-index (find-min i v)))
                  (begin (vector-swap! i smallest-index v)
                         (ss-vect-helper v (+ i 1))
                         )
                  )])
    )
  (ss-vect-helper vect 0)
  
  )

#|
23.13 Why doesn't this work?
(define (vector–swap! vector index1 index2)
  (vector–set! vector index1 (vector–ref vector index2))
  (vector–set! vector index2 (vector–ref vector index1)))

answer:
since we didn't store the value of 1st index in a temp variable
by the time when we swap the 2nd value the value wouldve been lost


example
(swap (vector 1 2 3)0 1)
we wanna swap 1 with 2
following the code
we swap 1 with 2, so now (vector 2 2 3)
by the time we swap 2nd one it doesn't remember the 1st value

|#

; --------------------------------------

#|
23.14 Implement a two-dimensional version of vectors. (We'll call one of these structures a matrix.) The 
implementation will use a vector of vectors. For example, a three-by-five matrix will be a three-element vector, in 
which each of the elements is a five-element vector. Here's how it should work:
> (define m (make–matrix 3 5))
> (matrix–set! m 2 1 '(her majesty))
> (matrix–ref m 2 1)
(HER MAJESTY)
|#

; vector map from preivous exercise
(define (vector-map vect f)
  (let ((new-vect (make-vector (vector-length vect) 0)))
    (define (helper v i)
      (cond [(>= i (vector-length vect) ) 'done]
            [else (let* ((curr-item (vector-ref v i))
                         (mapped-item (f curr-item)))
                    (begin (vector-set! new-vect i mapped-item)
                           (helper v (+ i 1))
                           )
                    )])
      )
    (helper vect 0)
    new-vect
    )
  )

; i = rows, j = column, aka row dominant?
; initializes matrix of i element vector with each having j elements
; example: (vector (vector j1 j2 j3) (vector j4 j5 j6))
(define (make-matrix i j)
  (let ((row-vect (make-vector i 0)))
      (vector-map row-vect (λ (r) (make-vector j 0))))
  
  )

; given a matrix and 2 index mutates the matrix
(define (matrix-set! matrix i j new-value)
  (vector-set! (vector-ref matrix i) j new-value)
  )
; given a matrix and 2 index, extracts the value
(define (matrix-ref m i j)
  (vector-ref (vector-ref m i) j)
  )

; ============================================

#|
23.15 Generalize Exercise 23.14 by implementing an array structure that can have any number of dimensions. Instead 
of taking two numbers as index arguments, as the matrix procedures do, the array procedures will take one argument, a 
list of numbers. The number of numbers is the number of dimensions, and it will be constant for any particular array. 
For example, here is a three-dimensional array (4 × 5 × 6):

> (define al (make–array '(4 5 6)))
> (array–set! al '(3 2 3) '(the end))
|#

; given a list of numbers, creates n dimensional array
(define (make-array list-of-numbers)

  ;; list -> vector
  (define (helper xs)
    (cond [(null? (cdr xs)) (make-vector (car xs) 0)] ;1d vector
          [else (vector-map (make-vector (car xs) 0) (λ (v) (helper (cdr xs))) ) ];
          )
    )
  (helper list-of-numbers)
  )

;(make-array '(2)) ;just one dimensional with 2 items
;(make-array '(2 2)) ; 2x2 array, 2 rows with each having 2 items
;(make-array '(2 2 2)) ;2x2x2 array; 2i with each having 2j with each having 2k item

(define sample-arr (make-array '(2 2 3)))
; given an ndimensional array, extracts its value based on given indeces
(define (array-ref arr list-of-indexes)
  
  (define (helper v ixs)
    (cond [(null? (cdr ixs)) (vector-ref v (car ixs))] ;1d vector, just get the indexref 
          [else (helper (vector-ref v (car ixs)) (cdr ixs)) ] ;else "unwrap" it
          )
    )
  (helper arr list-of-indexes)
  
  )
;sample-arr
;(array-ref sample-arr '(0 0 0))

; given an array, mutates its value at given indeces with new value
(define (array-set! arr list-of-indexes new-value)
  (define (helper v ixs)
    (cond [(null? (cdr ixs)) (begin (vector-set! v (car ixs) new-value)
                                    arr
                                    )] ;1d vector, mutate it
          [else (helper (vector-ref v (car ixs)) (cdr ixs))]
          )
    )
  (helper arr list-of-indexes)
  )

#|
23.16 We want to reimplement sentences as vectors instead of lists.
(a) Write versions of sentence, empty?, first, butfirst, last, and butlast that use vectors. Your 
selectors need only work for sentences, not for words.
> (sentence 'a 'b 'c)
#(A B C)
> (butfirst (sentence 'a 'b 'c))
#(B C)
(You don't have to make these procedures work on lists as well as vectors!)

answer:
|#

; SENTENCE
(define (se-vect . arguments)
  ; build vector length of args
  ; for each item vector it with car arg
  ; (define vect (apply vector args))
  ; or just do
  #|
  (define (calc-vect-length args)
    (cond [(null? args) 0]
          [(word? (car args)) (+ (calc-vect-length (cdr args)) 1)]
          [else (+  (vector-length (car args)) (calc-vect-length (cdr args))) ] ;nested vector, count the length
          )
    )
  (calc-vect-length arguments)
  |#

  (list->vector arguments)
  )



; BUTFIRST
(define (bf-vect vect)
  (define new-vect (make-vector (- (vector-length vect) 1)))
  
  (define (helper v i)
    (cond [(< i 1) new-vect]
          [else (let ((curr-value (vector-ref v i)))
                  (begin (vector-set! new-vect (- i 1) curr-value)
                         (helper v (- i 1))
                         )
                  )]
          )
    )
  (helper vect (- (vector-length vect) 1))
  )
;(bf-vect (se-vect 'a 'b 'c))
;(bf-vect (se-vect 'a 'b))

; EMPTY
(define (empty-se-vect? vect)
  (< (vector-length vect) 1)
  )

; LAST
(define (last-vect vect)
  (vector-ref vect (- (vector-length vect) 1))
  )
;(last-vect (vector 1)) ;#(1)
;(last-vect (vector 1 2 3)) ;#(3)

; BUTLAST
(define (bl-vect vect)
  (define new-vect (make-vector (- (vector-length vect) 1)))
  
  (define (helper v i)
    (cond [(>= i (- (vector-length vect) 1)) new-vect]
          [else (let ((curr-value (vector-ref v i)))
                  (begin (vector-set! new-vect i curr-value)
                         (helper v (+ i 1))
                         )
                  )]
          )
    )
  (helper vect 0)
  )
;(bl-vect (se-vect 'a)) ; #()
;(bl-vect (se-vect 'a 'b)) ; #(a)
;(bl-vect (se-vect 'a 'b 'c)) ;(a b)


; PART C
; no since sentence takes a vector
; use vector append

; PART d
; just use vector-ref
; with the index offset by (n-1)

#|
PART E

Does the following program still work with the new implementation of sentences?
If not, fix the program. If so, is there some optional rewriting that would improve its performance?


(define (every fn sent)
  (if (empty? sent)
      sent
      (sentence (fn (first sent))
                (every fn (butfirst sent)))))

; answer
it wont work if thres nested vector
also we can use vector map since butfirst rebuilds the vector on each call

|#

#|
First/Last
vector: instant
list: first is instant, last is linear (walk the whole list)

bf/bl:
vector: both are slow
list: bf is instant (just use cdr), but bl is slow

sentence:
list: fast for adding to front
vector: slow since need to adjust the size length


|#