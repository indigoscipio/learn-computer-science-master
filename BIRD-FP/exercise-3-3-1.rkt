#lang racket

; 3.3.1
; express #[e | x <- xs; y <- ys] in terms of #xs and #ys

#|
answer:
ok so it wants me to express the list comprehension lets analyze what it does
#[e | x <- xs; y <- ys]
we have 2 lists herexs and ys and it wants to figure out the length
small example
x = [1,2]
y = [3,4]

value of e
x - 1
 y - 3
 y - 4
x - 2
 y - 3
 y - 4
so the list is [3 4 3 4] and length is 4

now how do i express it in terms of #xs and #ys?
they are multiple of each other, in other words #xs * #ys = total length

------

3.3.2
which of the following equations are true and which are false?

[[]] ++ xs = xs
[[]] ++ xs = [xs]
[[]] ++ xs = [[],xs]
[[]] ++ [xs] = [[],xs]
[xs] ++ [] = [xs]
[xs] ++ [xs] = [xs,xs]

answer:
1. [[]] ++ xs = xs
ok so here we have a concat operation
with list containing one empty list and concatenate it with a list
the result is = [], xs so the empty list is actually being appended inside xs
so the answre is false

2. 
[[]] ++ xs = [xs]
here we have a similar one with the previous one
a list containing one empty list is concatenated with xs
the empty list is appended into xs and the result is [[], x1, x2, x3, etc] and not [xs]\
so its false

3. [[]] ++ xs = [[],xs]
this one is false

4. [[]] ++ [xs] = [[],xs]
here we have a list containing one empty list and wanna concat it with [xs] which is
left: [[]] -> []
right: [xs] -> xs
concat them together so [[],xs] so its true

5. [xs] ++ [] = [xs]
here we have a list that contains a list and we want to concat it with an empty list
so we unwrap [xs] -> xs -> append -> [xs] the result should be [xs]
so true

6. [xs] ++ [xs] = [xs,xs]
left: xs
right: xs
concat them together [xs, xs]
therefore its true

------

3.3.3
give informal characteriaztion of those finite lists xs and ys which satisfy
xs ++ ys = ys ++xs

let xs = [1,2]
ys = [1,2,3]
xs ++ ys = [1,2,1,2,3]
ys ++ xs = [1,2,3,1,2]
ys does not equal xs
xs does not equal ys

they don't match if each item and length in xs does not equal to ys
two lists xs and ys satisfites xs ++ ys == xs ++ ys if they are both repetiitons
of the same smaller list

------

3.3.4
what is the value of [hd xs] ++ tl xs when xs = []
answer:
lets evaluate this one by one
left: [hd xs]
hd xs -> since xs is empty list it cannot get the tail so error

right: tl xs = error since its an empty list, cannot get the tail of an empty list

so this operation is down/undefined/error

------

3.3.5
show using informal arg that if p is the min of m and n, then
take m . take n = take p

answer:
since take p is min(m,n) it always return either m or n whichever the lowest
let m = 2
let n = 3

take 2 . take 3 = take 2
let xs = [10,20,30,40]
LHS -> take 3 -> [10,20,30] -> take 2 -> [10,20]
RHS -> take 2 -> [10,20]
the result is the same

------

3.3.6
verify or disprove the asssertion that
(drop n xs) ! m = xs ! (n + m)

answer:
LHS -> we have a list index operation with (drop n xs) as the list and wanna get the mth index value
RHS -> same list index op, with xs as the list and we wanna get the value of (n+m)'s index

small example
let xs = [1,2,3,4,5]
m = 1
n = 2

LHS
(drop 2 [1,2,3,4,5]) ! 1
[3,4,5] ! 1
returns the 1st index = 4

RHS
[1,2,3,4,5] ! 3
= 4

seems to work since theyre equal so far
does it always work for all list? what about non empty list? -> return undefined
or if n or m is greater than the length of the list? -> return error

xs ! (n + m) - start at beginning, walk m houses and walk n houses. tell me who's there
(drop n xs) ! m - delete first n houses. starting from the beginning of whats left walk m houses.

in both cases you end up at the same door


-----

3.3.7
is zip associative in the sense that
zip(xs, zip (ys, zs)) = zip(zip(xs,ys),zs)?
for all xs, ys, and zs?

answer:

small example
let xs = [1,2,3]
let ys = [4,5]
let zs = [6,7,8]

LHS
zip(xs, zip (ys, zs))
zip (ys, zs) -> [[4,6],[5,7]]
zip(xs, zip (ys, zs)) -> [[1,[4,6]],[2,[5,7]]]

RHS
zip(zip(xs,ys),zs)
zip(xs,ys) -> [[1,4],[2,5]]
zip(zip(xs,ys),zs) -> [[[1,4],6],[[2,5],7]]

looks to be correct so far
while both sides contain same elements, they are packaged/grouped in a different way
LHS is a list of pairs where [[1,[4,6]],[2,[5,7]]]
and RHS is [[[1,4],6],[[2,5],7]]
because the nesting is different they are not strictly equal.

-----

3.3.8
using zip define the function zip4 which converts a 4-tuple of lists into a list of 4 tuples

input: [[x1,x2,...],[y1,y2,...],[z1,z2,...],[w1,w2,...]
output: [[x1,y1,z1,w1],[x2,y2,z2,w2],...]

zip:: [a,a,a,a] -> [???]
zip4 (xs, yz, zs, ws) = [(x,y,z,w) | x <- xs, y <- yz , z <- zs , w <- ws ]

|#

;3.3.9
;define function trips so that trips xs returns a list of all adjacent triples of elements of xs

; answer
; List-of-x -> List-of-List-of-x
(define (trips xs)
  (cond [(not (and (pair? xs) (pair? (cdr xs)) (pair? (cddr xs)))) '()]
        [else (let ((first-el (car xs))
                    (second-el (cadr xs))
                    (third-el (caddr xs))
                    )
               (cons (list first-el second-el third-el) (trips (cdr xs)) )
                ) ])
  )
(trips '(1 2 3 4 5)) ; '((1 2 3) (2 3 4) (3 4 5))

#|
find xs and ys such that

(xs ++ ys) -- ys does not equal xs

answer:
start with small example
let xs = [1,2,3]
let ys = [4,5]

LHS
(xs ++ ys) -- ys
[1,2,3,4,5] -- [4,5] = [1,2,3] - equals to xs

find another counterexample
xs = []
ys = [1,2]
(xs ++ ys) -- ys
[] = []

xs = [1,2]
ys = []
(xs ++ ys) -- ys
[1,2] = [1,2]

xs = [1]
ys = [1,2]
(xs ++ ys) -- ys
[1,1,2] -- [1,2] = [1]

xs = [1,2]
ys = [1]
(xs ++ ys) -- ys
[1,2,1] -- [1] = [1,2]

...


|#
