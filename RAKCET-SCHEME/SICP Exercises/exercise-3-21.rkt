#lang sicp


(define (make-queue) (cons '() '()))
(define my-queue (make-queue))


(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))

; Queue Any -> Queue
(define (set-front-ptr! queue item)
  (set-car! queue item)
  )


; Queue Any -> Queue
(define (set-rear-ptr! queue item)
  (set-cdr! queue item)
  )

; Checks if a queue is empty
(define (empty-queue? queue)
  (null? (front-ptr queue))
  )


; Selects the front queue of a queue
(define (front-queue queue)
  (cond [(empty-queue? queue) (error "front-queue is called with empty queue:" queue)]
        [else (front-ptr queue)])
  )

; Inserts a new item into the front of a queue
; Queue Any -> Queue 
(define (insert-queue! queue item)
  ; create a new pair whose car is the item to be inserted and whose cdr is the empty list
  ; if the queue was empty, we set the front and rear pointers of the queue to the new pair
  ; else, we modify the final pair in the queue to point to the new pair, and also set the rear pointer to the new pair
  (let ((new-pair (cons item '())))
    (cond [(empty-queue? queue) (set-front-ptr! queue new-pair)
                                (set-rear-ptr! queue new-pair)
                                queue
                                ]
          [else (set-cdr! (rear-ptr queue) new-pair)
                (set-rear-ptr! queue new-pair)])
    )
  )


(define (delete-queue! queue)
  ; modify the front pointer so it points to the cdr of the first item
  (cond [(empty-queue? queue) (error "delete-queue is called with an empty queue" queue)]
        [else (set-front-ptr! queue (cdr (front-ptr queue)))])
  )



;exercise 3.21
; Queue -> Queue
(define (print-queue queue)
  ; List-of-Item -> List-of-Item
  (define (print-list l)
    (cond [(null? l) (newline)]
          [else
           (display (car l))
           (newline)
           (print-list (cdr l))])
    )
  (print-list (front-ptr queue)))


(define q (make-queue))
(insert-queue! q 'a)
(insert-queue! q 'b)
(insert-queue! q 'c)
(insert-queue! q 'd)
q
;(delete-queue! q)
(print-queue q)

