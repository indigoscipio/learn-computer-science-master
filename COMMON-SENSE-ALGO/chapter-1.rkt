#lang racket

(let loop ((x 10))
  (cond [(zero? x) 0]
        [else (cons x (loop (- x 1)))]
        )
  )

(for [(i (list 1 2 3))]
  (println i)
  )

; Time is not a good yardstick
; 2 seconds to run -> might run slow on older machine
; steps stay the same
; list vs vector -> vector is isntant, list is linear

#|
1.
For an array containing 100 elements, provide the number of steps the
following operations would take:

a. reading
b. searching for a value not contained within an array
c. Insertion at the beginning of the array
d. Insertion at the end of the array
e. Deletion at the beginning of the array
f. Deletion at the end of the array

answer:
ok so we know there vectors with length n = 100 elements
a. for reading, vector is instant, 1 step
b. has to scan through the end, so n
c. has to 'reposition' the rest of the vectors to correct posoition,
then place the the item to the first index so n + 1
reposition the 100 -> 100
insert the 1 -> 1
so total is n + 1
d. i think this is quick/instang no needto reposition, 1 step
e. needs to delete 1st item then reposition the rest, so n
 remove 1st element (1 step)
shift remaining 99, so 99 + 1 -> 100 -> n
f. this is also instant


___________________________________

For an array-based set containing 100 elements, provide the number of
steps the following operations would take:

|#