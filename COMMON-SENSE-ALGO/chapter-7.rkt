#lang racket

; chapter 7
; AVG OF EVEN

; functional style/list based
(define (avg-of-even xs)
  (define (loop curr-xs even-sum even-count)
    (cond [(null? curr-xs) (/ even-sum even-count)]
          [(even? (car curr-xs)) (loop (cdr curr-xs)
                                       (+ (car curr-xs) even-sum)
                                       (+ 1 even-count) )]
          [else (loop (cdr curr-xs) even-sum even-count)]
          )
    )
  (loop xs 0 0)
  )
(avg-of-even '(1 2 3 4 5 6)) ; 12 / 3 = 4

; imperative style/vector
(define (avg-of-even-v2 vect)
  (let ((n (- (vector-length vect)1)))

    (define (helper i sum count)
      (cond [(> i n) (/ sum count)]
            [(even? (vector-ref vect i)) (helper (+ i 1)
                                                 (+ (vector-ref vect i) sum)
                                                 (+ 1 count)) ]
            [else (helper (+ i 1) sum count)]
            )
      )
    (helper 0 0 0)

    )
  )
(avg-of-even-v2 (vector 1 2 3 4 5 6))

; ===================================
; WORD BUILDER

; functional/list style
(define (word-builder-v1 xs)
  ; inner loop/helper
  ; inserts at end, except if x = car xs
  (define (insert-at-end-to-each x xs)
    (cond [(null? xs) '()]
          [(equal? x (car xs)) (insert-at-end-to-each x (cdr xs)) ] ; skip
          [else (let* ((str0 (symbol->string (car xs)))
                       (str1 (symbol->string x))
                       (combined (string-append str1 str0))
                       )
                  (cons combined
                        (insert-at-end-to-each x (cdr xs)))
                  )]
          )
    )
  
  ; outer loop
  (define (loop curr-xs result)
    (cond [(null? curr-xs) result]
          [else (loop (cdr curr-xs)
                      (append (insert-at-end-to-each (car curr-xs) xs)
                              result)) ]
          )
    )
  (insert-at-end-to-each 'a '(a b c d)) ; '(ab ac ad)
  (loop xs '())
  
  )
(word-builder-v1 '(a b c d))


; imperative/vector
(define (word-builder-v2 vect)
  (let* ((n (- (vector-length vect) 1))
         (len (vector-length vect))
         (total-len (* len (- len 1)))
         (result-vect (make-vector total-len)))

    ; outer loop: i
    ; inner loop: j
    (define (loop i j k)
      (cond [(> i n) result-vect] ;done
            [(> j n) (loop (+ i 1) 0 k) ] ;move to next row
            [else (let* ((curr-row (vector-ref vect i))
                         (curr-col (vector-ref vect j))
                         (appended-val (string-append (symbol->string curr-row)
                                                      (symbol->string curr-col)))
                         )
                    ; append to each
                    (if (= i j)
                        (loop i (+ j 1) k)
                        (begin (vector-set! result-vect k appended-val)
                               (loop i (+ j 1) (+ k 1)))
                        )
                    )])
      )
    (loop 0 0 0)    
    
    )
  )
(word-builder-v2 (vector 'a 'b 'c 'd))

; ================================================

; ARRAY SAMPle
(define (array-sample vect)
  (let ((n (- (vector-length vect) 1)))
    (vector (vector-ref vect 0)
            (vector-ref vect (quotient n 2))
            (vector-ref vect n))
    )
  )
(array-sample (vector 1 2 3 4 5 6 7 8 9 10))


; ================================================

; INVENTORY
; not O(n^2) -> because outer loop runs n time
; but inner loop runs only up to 5 constant time
; 5N -> O(n)

; ================================================

; COUNT ONES
; not O(n^2)
; open box 1 -> pick up one by one. count and put aside
; open box 2, repeat until every box isempty
; total candies = exactly n (all items flatenned)

(define (count-ones vect)
  (let ((n (- (vector-length vect) 1) ))

    #|
    WITH FOR/FOLD
    ; outer loop
    (for*/fold ((count 0))
               ((row vect)
                (item row))
      ; inner loop
      (if (= item 1)
          (+ count 1)
          count
          )
      )
    |#

    ;i = row
    ;j = col
    (define (loop i j count)
      (cond [(> i n) count]
            [(> j (- (vector-length (vector-ref vect i)) 1) ) (loop (+ i 1) 0 count)]
            [else (let* ((curr-row (vector-ref vect i))
                         (curr-val (vector-ref curr-row j))
                         )
                    (if (= curr-val 1)
                        (loop i (+ j 1) (+ count 1))
                        (loop i (+ j 1) count)
                        )
                    )]
            )
      )
    (loop 0 0 0)
    
    )
  )
(count-ones (vector (vector 0 1 1 1 0)
                    (vector 0 1 0 1 0 1)
                    (vector 1 0)))


; ==========================================

;PALINDROME CHCECKER

; functional style
; lets just use symbol instead of string simpler
; list-of-symbol -> boolean
(define (palindrome-v1 xs)
  (equal? xs (reverse xs))
  )
(palindrome-v1 '(r a c e c a r)) ;#t
(palindrome-v1 '(h e l l o))


; imperative style
; vector -> boolean
(define (palindrome-v2 vect)
  (let ((n (- (vector-length vect) 1)))


    ;manual vector recursion
    (define (loop left-index right-index)
      (cond [(>= left-index right-index) #t]
            [else (let ((left-val (vector-ref vect left-index))
                        (right-val (vector-ref vect right-index))
                        )
                    (if (equal? left-val right-val)
                        (loop (+ left-index 1) (- right-index 1))
                        #f
                        )
                    )]
            )
      )
    (loop 0 n)


    
    )
  )
(palindrome-v2 (vector 'r 'a 'c 'e 'c 'a 'r))
(palindrome-v2 (vector 'h 'e 'l 'l 'o))

; ==========================================

; GET ALL PRODUCTS

; functional/list style
(define (get-all-products-v1 xs)
  ; 1 -> 2 3 4 5
  ; 2 -> 3 4 5
  ; 3 -> 4 5
  ; 4 -> 5
  ; helper:: number list-of-number -> list-of-number
  ; wait i dont need custo mrecursive just use map
  (define (helper xs)
    (cond [(null? xs) '()]
          [else (let* ((rest (cdr xs))
                       (rest-multiplied (map (λ (x) (* (car xs) x)) rest) ))
                  (append rest-multiplied (helper (cdr xs)))
                  )]
          )
    )
  (helper '(1 2 3 4 5)) ;should return '(6 8 10)
  
  )
(get-all-products-v1 '(1 2 3 4 5)) ;returns list of unique product pairs

; imperative/vector style
(define (get-all-products-v2 vect)
  (let ((n (- (vector-length vect) 1)))

    #|
    ;manual recursion
    (define (loop i j result)
      (cond [(> i n) (list->vector (reverse result))] ;outer loop
            [(> j n) (loop (+ i 1) (+ i 2) result)]
            [else (let ((num-outer (vector-ref vect i))
                        (num-inner (vector-ref vect j)))
                    (loop i (+ j 1) (cons (* num-outer num-inner) result))
                    )]
            )
      )
    (loop 0 1 '())
    |#
    
   
    ;with for/fold
    (for*/fold ((products '()))
               ((i (in-range 0 (vector-length vect))) (j (in-range (+ i 1) (vector-length vect))))
      (cons (* (vector-ref vect i) (vector-ref vect j)) products)
      )
    
    )
  )
(get-all-products-v2 (vector 1 2 3 4 5))

; ================================

; TWO NUM PRODUCTS
; functional/list style
; list-of-number list-f-number -> list-of-number
(define (two-num-products xs ys)
  (apply append (map (λ (x) (map (λ (y) (* x y)) ys) ) xs))
  )
(two-num-products '(1 2 3) '(10 100 1000))

; imperative /vector style
(define (two-num-products-v2 vect1 vect2)
  (for*/fold ((result '()))
             ((i (in-range 0 (vector-length vect1)))
              (j (in-range 0 (vector-length vect2))))
    (cons (* (vector-ref vect1 i) (vector-ref vect2 j)) result)
    )
  )
(two-num-products-v2 (vector 1 2 3) (vector 10 100 1000))

; ================================

; EXERCISE
#|

1. Use Big O notation to describe the time complexity of the following func
tion. The function returns True if the array is a 100-sum array, and False
if it is not.

A 100-sum array meets the following criteria:
• Its first and last numbers add up to 100.
• Its second and second-to-last numbers add up to 100.
• Its third and third-to-last numbers add up to 100, and so on.

Here’s the function:
def one_hundred_sum(array):
if (len(array) % 2 != 0) or not array:
return False
left_index = 0
right_index = len(array)- 1
while left_index < (len(array) // 2):
if array[left_index] + array[right_index] != 100:
return False
left_index += 1
right_index-= 1
return True

answer:
ok lets analyze this, im not fmailair with python
so by the definition if we have
x1 x2 x3 .... xn
x1 + xn = 100
x2 + xn-1 = 100
x3 + xxn-2 = 100 ... etc

and for the code signature
array -> boolean

first if check -> insant

while loop that only runs when
0 < array length // 2 so this only runs for n/2 time
and inside it we check if the actual value sums to 100
and theres a simple comparison/short circuit which returns false
if sum is not 100

so in terms of time complexity
n/2 -> O(n)

_

2. 
 Use Big O notation to describe the time complexity of the following func
tion. It merges two sorted arrays to create a new sorted array containing
all the values from both arrays:

def merge(array_1, array_2):
new_array = []
array_1_pointer = 0
array_2_pointer = 0
# Run the loop until we've reached end of both arrays:
while array_1_pointer < len(array_1) or array_2_pointer < len(array_2):
# If we already reached the end of the first array,
# add item from second array:
if array_1_pointer >= len(array_1):
new_array.append(array_2[array_2_pointer])
array_2_pointer += 1
# If we already reached the end of the second array,
# add item from first array:
elif array_2_pointer >= len(array_2):
new_array.append(array_1[array_1_pointer])
array_1_pointer += 1
# If the current number in first array is less than current
# number in second array, add from first array:
elif array_1[array_1_pointer] < array_2[array_2_pointer]:
new_array.append(array_1[array_1_pointer])
array_1_pointer += 1
# If the current number in second array is less than or equal
# to current number in first array, add from second array:
else:
new_array.append(array_2[array_2_pointer])
array_2_pointer += 1
return new_array

answer:
ok so thisis along one i think im abit familar
this is a helper for mergesort
ifiremember mergesort takes n log n but for the merge 
lets analyze

ok so th ewhile loop here it runs
for the length of the first array + the length of the second array
even if the first one is empty second array will be checkd till the end
so n + n -> 2n

and inside of that we have a few if cases and comparison
which takes constant (3 + 3 + 3 + 2) -> approximately 10

so i guess running time is  2n + 10 so big O notation is still O(n)

_

3. Use Big O notation to describe the time complexity of the following func
tion. This function solves a famous problem known as “finding a needle
in the haystack.

Both the needle and haystack are strings. For example, if the needle is
"def" and the haystack is "abcdefghi", the needle is contained somewhere in
the haystack, as "def" is a substring of "abcdefghi". However, if the needle
is "dd", it cannot be found in the haystack of "abcdefghi".

This function returns True or False depending on whether the needle can
be found in the haystack:

def find_needle(needle, haystack):
needle_start_index = 0
while needle_start_index <= len(haystack)- len(needle):
if needle[0] == haystack[needle_start_index]:
needle_offset = 0
while needle_offset < len(needle):
if (needle[needle_offset]
!= haystack[needle_start_index + needle_offset]):
break
else:
if needle_offset == len(needle)- 1:
return True
needle_offset += 1
needle_start_index += 1
return False

answer:
ok lets try to analyze this again
this seems familiar its like the 'sliding window' problem but not sure, letsc heck

function signature is string string -> boolean
each string is a list of characters
not sure if that works the same in python

outer loop checks from start index up to...
lets do small exmaple
haystack = "abcdef" -> n = 6
needle = "def" -> n = 3

len(haystack) - len(needle)
6 - 3 = 3

hmm so this is variative dpending on the length of the two strigns
butworstcase it can be n-1 assuming the needle is nonempty

next while loop we iterate through the nedle offset
so basically the inner loop only happens when the lettero
of each two string is t he same, eg when its in "d" part in "abcdef"
so here we wanna check if this part is "def"
which means it runs for the length from needle offset to length of the needle

so combining the two loops
n-1 . length of the needle array, lets say its m length
n-1 . m
so i guess O(n*m)? or something, not sure

_

4. Use Big O notation to describe the time complexity of the following func
tion. This function finds the greatest product of three numbers from a
given array:

def largest_product(array):
if len(array) < 3:
return None
largest_product_so_far = array[0] * array[1] * array[2]
i = 0
while i < len(array):
j = i + 1
while j < len(array):
k = j + 1
while k < len(array):
if array[i] * array[j] * array[k] > largest_product_so_far:
largest_product_so_far = array[i] * array[j] * array[k]
k += 1
j += 1
i += 1
return largest_product_so_far

answer:
lets try to analze this
funciton signature is array -> number

first init larges tproduct to the product of the first 3
and init i = 0
let n be the length of the array

then we have 3 loops

outer
runs i up to length of the array, so n times

mid
runs from i+1 up to length of the array -> n - 1 ?? could be wrong but still n

inner
runs from j+1 (i+2) up to length of the array -> n -2

then the innermost body just increments laye by layer

so total
n . n-1 . n-2
n^3 so in terms of time complexity its O(n^3)
_


5. I once saw a joke aimed at HR people: “Want to immediately eliminate
the unluckiest people from your hiring process? Just take half of the
resumes on your desk and throw them in the trash.”

If we were to write software that kept reducing a pile of resumes until we
had one left, it might take the approach of alternating between throwing
out the top half and the bottom half; that is, it will first eliminate the top
half of the pile, and then proceed to eliminate the bottom half of what
remains. It keeps alternating between eliminating the top and bottom
until one lucky resume remains, and that’s who we’ll hire!

Describe the efficiency of this function in terms of Big O:
def pick_resume(resumes):
if not resumes:
return None
eliminate = "top"
while len(resumes) > 1:
midpoint = len(resumes) // 2
if eliminate == "top":
resumes = resumes[:midpoint]
eliminate = "bottom"
elif eliminate == "bottom":
resumes = resumes[-midpoint:]
eliminate = "top"
return resumes[0]

answer:

ok lets analyze this
my instinct tells this is a divide and conquer thing so basically somerewhere
in the log n or n log n area if theres recursion but lets check

let n represent the length of the resumes
the function signature is array -> number

while loop runs as long as n > 1
then we init midpoint m = n/2

im not sure what the resumes[:midpoint] do but im assuming
its just starting at the midpoint/eliminating the top?
so itjust divide by 2? not familiar with python

so if we have n = 16
16 -> 8 -> 4 -> 2 -> 1

which is log n time
so time complexity is O(log n)??
O(n)


|#
