#lang racket

#|
Problem 18: Maximum Path Sum 1

By starting at the top of the triangle below and moving to adjacent numbers on the row below,
the maximum total from top to bottom is 23

   3
  7 4
 2 4 6 
8 5 9 3

that is, 3+7+4+9 = 23

find the maximum total from top to mottom of the triangle below

75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23

NOTE: as there are only 16384 routes, it is possible to solve this problem by trying every rote.
However, PRoblem 67 is the same challenge with a triangle countaining 100 rows; it cannot be solved by
brute force and requires a clever method.

answer:
ok let me think about htis from the example

row 1 -> 3
row 2 -> 3 4
row 3 -> 2 4 6
row 4 -> 8 5 9 3

to find the biggest, start from row 1. iterate through the column

then row2, col1 (3+7)
then row3, col1 (3+7+2)
then row4, col1 (3+7+2+8)
then at the end of col1's row, save the value to a variable.

then move on to the next column (col + 1), starting again from row1
then row2, col2 (3+4)
then row3, col2 (3+4+4)
then row4, col2 (3+4+4+5)
repeat until it reaches the last column

i think thats the simplest approach, the note said problem 67 but this is still problem 18
so im just gonna go with this approach for now

implmenetation wise im not quite sure in racket but let me try
we need the main master funciton, a helper that counts each 'col'

|#

(define triangle
  '((75)
    (95 64)
    (17 47 82)
    (18 35 87 10)
    (20 04 82 47 65)
    (19 01 23 75 03 34)
    (88 02 77 73 07 63 67)
    (99 65 04 28 06 16 70 92)
    (41 41 26 56 83 40 80 70 33)
    (41 48 72 33 47 32 37 16 94 29)
    (53 71 44 65 25 43 91 52 97 51 14)
    (70 11 33 28 77 73 17 78 39 68 17 57)
    (91 71 52 38 17 14 91 43 58 50 27 29 48)
    (63 66 04 68 89 53 67 30 73 16 69 87 40 31)
    (04 62 98 27 23 09 70 98 73 93 38 53 60 04 23)))

; a triangle is a list of lists
; interpretation represents triangular number

(define TRIANGLE-DEPTH (length triangle)) ;returns 15

; triangle number number -> number
; What is the best path sum starting from position i in row r, going down to the bottom
; the children is next row with i and i + 1
(define (find-best-path triangle r i)
  (cond [(>= r TRIANGLE-DEPTH) 0] ;reaches the bottom
        [else (let* ((curr-row (list-ref triangle r))
                     (curr-val (list-ref curr-row i))
                     )
                (+ curr-val (max (find-best-path triangle (+ r 1) i)
                                 (find-best-path triangle (+ r 1) (+ i 1) )))
                )]
        )
  )

; given a triangular number list, returns its maximum path sum
(define (maximum-path-sum triangle)
  (find-best-path triangle 0 0)
  )
(maximum-path-sum triangle) ;returns 1074
