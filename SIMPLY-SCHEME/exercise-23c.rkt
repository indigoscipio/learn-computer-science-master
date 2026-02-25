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

(define (selection-sort-vect vect)

  )
(selection-sort)
