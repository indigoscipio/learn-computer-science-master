#lang racket

#|
10035 Primary Arithmetic
Children are taught to add multi-digit numbers from right-to-left one digit at a time. Many find the
“carry” operation - in which a 1 is carried from one digit position to be added to the next - to be a
significant challenge. Your job is to count the number of carry operations for each of a set of addition
problems so that educators may assess their difficulty.
Input
Each line of input contains two unsigned integers less than 10 digits. The last line of input contains ‘0
0’.
Output
For each line of input except the last you should compute and print the number of carry operations
that would result from adding the two numbers, in the format shown below.
Sample Input
123 456
555 555
123 594
0 0
Sample Output
No carry operation.
3 carry operations.
1 carry operation.
|#
; number numuber -> number
(define (count-carries n1 n2)
  ; start with the rightmost digit: add them together;
  ; repeat until last digit, then return the total
  (define (count-carries-h a b incoming-carry total-so-far)
    (let ((d1 (remainder a 10))
          (d2 (remainder b 10))
          (rem1 (quotient a 10))
          (rem2 (quotient b 10))
          )
      (cond [(and (zero? a)(zero? b)) total-so-far] ; base case, numbers are zeroes
            [(>= (+ d1 d2 incoming-carry) 10) (count-carries-h rem1 rem2 1 (+ 1 total-so-far))] ;add the carry
            [else (count-carries-h rem1 rem2 0 total-so-far)]; else just recurse
            )
      )
    )
  ;initialize with carry = 0
  (count-carries-h n1 n2 0 0)
  )
(count-carries 123 456) ; no carry ops
(count-carries 555 555)
(count-carries 123 594)