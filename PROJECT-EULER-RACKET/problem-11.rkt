#lang racket

#|
PROBLEM 11
in the 20x20 grid below
four numbers along a diagonal line have been marked in red.

08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08
49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00
81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65
52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91
22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80
24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50
32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70
67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21
24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72
21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95
78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92
16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57
86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58
19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40
04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66
88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69
04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36
20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16
20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54
01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48

The product of these numbers is 26 * 63 * 78 * 14 = 1788696

what is the greatest product of four adjacent numbers in the same direction (up, down, left, right, or diagonally)
in the 20x20 grid?

answer:

ok so we have a 20x20 input and we have 4 directions
so i think we need to trarverse like

so we can use the 'sliding window thing here for eaech direction, i think
- for each row find 4 greatest product, save to var
- for each col find the 4 greatest product, save to var
- for each diagonal find 4 greatest product, save to var

since the question asks for same direction, does it really matter if left -> right or right -> left?
maybe if its adjacent just check one direction to avoid overcomplicating everything?
then at the end crosscheck if everythings equal to each other
if so thats the greates adjacent, else it doesn't exist

|#

(define sample-grid '((08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08)
                      (49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00)
                      (81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65)
                      (52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91)
                      (22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80)
                      (24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50)
                      (32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70)
                      (67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21)
                      (24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72)
                      (21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95)
                      (78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92)
                      (16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57)
                      (86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58)
                      (19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40)
                      (04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66)
                      (88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69)
                      (04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36)
                      (20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16)
                      (20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54)
                      (01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48)))

; given a list of numbers, calculate all of its product
; product:: list-of-number -> number
(define (product xs)
  (foldr * 1 xs)
  )

; given a posint n and list of numbers xs, returns the greatest product of n adjacent number
; sum-of-greatest:: number list-of-number -> number
(define (sum-of-greatest n lst)
  
  (define (helper xs largest-so-far)
    (cond [(null? xs) largest-so-far] ;list is empty, return the result
          [(< (length xs) n) largest-so-far]
          [else (let ((curr-product (product (take xs n))))
                  (if (> curr-product largest-so-far)
                      (helper (cdr xs) curr-product)
                      (helper (cdr xs) largest-so-far)
                      )
                  )] 
          )
    )
  ; lets not overcomplicate
  (helper lst 0)
  
  )
(sum-of-greatest 1 '(1 2 3)) ; returns 3
(sum-of-greatest 2 '(2 4 6)) ; return 4*6 = 24
(sum-of-greatest 4 '(1 2 3)) ; error, n is less than the list length
(sum-of-greatest 4 '(1 2 3 4 5 6)) ; should return 3*4*5*6

; given a list of list of number (grid), transposes its position
(define (transpose grid)
  (cond [(null? grid) '()]
        [(null? (car grid)) '()]
        [else (let ((cols (map car grid))
                    (rest-cols (map cdr grid))
                    )
                (cons cols (transpose rest-cols))
                )]
        )
  )
(transpose '((1 2) (3 4) (5 6))) ;should return '((1 3 5) (2 4 6))

; down right diagnoal: row = col, increment at the same time for both, start both from 0
; up right -> decrease row (start at the end row), increase col (start from 0)
; assume width = height
(define (extract-diagonal-from start-row start-col width grid)
  (define (helper row-idx col-idx)
    (cond [(or (>= col-idx width) (>= row-idx width)) '()]
          [else (let* ((row (list-ref grid row-idx))
                       (el (list-ref row col-idx))
                       )
                  (cons el (helper (+ 1 row-idx) (+ 1 col-idx)))
                  )]
          )
    )
  (helper start-row start-col)
  )
(extract-diagonal-from 0 0 3 '((1 2 3) (4 5 6) (7 8 9)))

; given a grid, extracts all diagonals
(define (extract-all-diagonals grid)
  (cond [(null? grid) '()]
        [else (let ((1st-half (map (λ (n) (extract-diagonal-from 0 n (length grid) grid)) (range 0 (length grid))))
                    (2nd-half (map (λ (n) (extract-diagonal-from n 0 (length grid) grid)) (range 1 (length grid))))
                    )
                (append 1st-half 2nd-half)
                )
              ])
  )
(extract-all-diagonals '((1 2 3) (4 5 6) (7 8 9)))

(define (greatest-adjacent n grid)
  ; pull each row (h), col (v), right diagonal (d1), and left diagnoal (d2)
  (let* ((rows grid)
         (cols (transpose grid))
         (diagonals1 (extract-all-diagonals grid))
         (diagonals2 (extract-all-diagonals (reverse grid)))
         (greatest-in-rows (apply max (map (λ (r) (sum-of-greatest n r)) rows)) )
         (greatest-in-cols (apply max (map (λ (c) (sum-of-greatest n c)) cols)))
         (greatest-in-d1 (apply max (map (λ (d) (sum-of-greatest n d)) diagonals1)))
         (greatest-in-d2 (apply max (map (λ (d) (sum-of-greatest n d)) diagonals2)))
         )
    (max greatest-in-rows greatest-in-cols greatest-in-d1 greatest-in-d2)
    )
  )
(greatest-adjacent 2 '((1 2 3) (4 5 6) (7 8 9)))
(greatest-adjacent 4 sample-grid)

