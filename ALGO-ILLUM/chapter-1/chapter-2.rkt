#lang racket

; CHAPTER 2
; ASYMPTOTIC NOTATION

; focus on dominant constant factor
; ignore constant/lower order temrs
; suppress constant factors and lower order temrs

#|
Quiz 2.1
What istheasymptoticrunningtimeofthecodeabovefor
searchingonearray,asafunctionofthearraylengthn?
a)O(1)
b)O(logn)
c)O(n)
d)O(n2)


answer:
since it checks each integer one by one its just O(n)/linear
grows with input size, worst case would have to look every single element once

_____________________

Quiz2.2
What istheasymptoticrunningtimeofthecodeabovefor
searchingtwoarrays,asafunctionofthearraylengthsn?
a)O(1)
b)O(logn)
c)O(n)
d)O(n2)

answre:
so we check one array -> if its not there, check the other one
so thats like n + n -> 2n
ignoring the constant we still have O(n) for worst case

_____________________
Quiz 2.3

What istheasymptoticrunningtimeofthecodeabovefor
checkingforacommonelement,asafunctionofthearray
lengthsn?

answer:
step 1 -> loop into array a -> n
step 2 -> for each item in array a, loop over array b -> n

so total work is n . n = n^2

_____________________

Quiz2.4
What istheasymptoticrunningtimeofthecodeabovefor
checkingforduplicates,asafunctionofthearraylengthn?
a)O(1)
b)O(logn)
c)O(n)
d. O(n^2)

answer:
n-1 comparisons (= (car x) (cadr x)) -> O(n)
n^2

|#