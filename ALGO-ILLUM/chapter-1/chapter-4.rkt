#lang racket

; CHAPTER 4: The Master Method

#|

T(n) = a . T(n/b) + O(n^d)
a = number of smaller subproblem spawned/branced (recursive calls)
b = factor by which input size shrinks (n/2 = halfing the size)
d = exponent in running time in 'combine' step

T(n) = work done by recursive call + work done outside recursive call

requirement
- b > 1 must shrink by same factor b
- a >= 1, must recurse atleast 1 time
- d >=0, outside calls work must be atleast O(1)

case:
- root win: a < b^d -> O(n^d)
input shrinks faster than subproblem spawns
most work at the root/top

- tie: a = b^d -> O(n^d . logn)
work equally balanced
spawns smaller subproblem and shrinks input equally

- leaves win: a > b^d -> O(n^logb a)
spawns new branches more than reducing the problem/input
most work happen a the bottom

example: Merge Sort
subproblem spawned = a = 2
input shrinked =  b = 2
merge/outside problem -> d=1

b^d = 2
a = 2
2 = 2 -> tie

Karatsuba
subproblem spawned -> a = 3
input shrinked -> b = 2
outside computation -> d = 1 (addition, comparison, combine, split etc)

b^d = 2^1 = 2
a = 3

so here a > b^3
which means leaves win?

|#

; ===============================

#|

EXAMPLES
1. MERGESORT

a = num or recursive calls = 2
b = input/problems reduced = 2
d = work done outside recursive = 1

2 = 2^1
2 = 2
this falls wihin the equal case/balanced

_

2. BINARY SORT
a = 1 -> throw the wrong half and only keep the correct one
b = halfed -> 2
d = 0 -> 1 comparison to decide which half to throw

1 = 2^0
1 = 1
tie case

_

3. RECMULT
a = 4
b = 2
d = 1

_

QUIZ 4.3
recmatmult
a = 8
b = 2

_

QUIZ 4.4
What is thepattern? Fill intheblanks inthe following
statement: ateachlevelj=0,1,2,...oftherecursiontree,
thereare[blank]subproblems,eachoperatingonasubarray
of length[blank].

a) a^j and n/a^j, respectively
b) a^j and n/b^j,respectively
c) b^j and n/a^j,respectively
d) b^j and n/b^j, respectively

answer:
ok so we know levle = j -> 0,1,2,... where 0 is the root
let subproblem = a, item in each subproblem = b
lets say n=8 items
level 0 -> j=0, a = 1, b = 8
level 1 -> j=1, a = 2, b = 8/2
level 2 -> j=2, a = 2.2=4, b = 8/(2.2)=2
level 3 -> j=3, a = 2.2.2=8, b = 8/(2.2.2)=1

so the pattern follows
2^j and n/2^j


_

to find total work, sum the work done at each level
total work = sum of all work done at each level

work at level j = a^j . c . (n/b^j)^d
n = problem size, total size of n
a = branching factor (recursive calls)
b = shrink factor
d = work exponent ourside call
j = tree leve/floor

work at level j = [workers at level j] . c . [problems shrinked at level j]^d
work = c . (n/b^j)^d

total work = work at level 0 * sum of multipliers for every floor
root wins -> 1 + 1/2 + 1/4 + ... -> never reaches 2
tie -> 1 + 1 + 1 + 1 = number of levels
leaves win -> 1 + 2 + 4 + 8 + .... 2^height -> most leaves hold the answer

evil = a (recursive calls) - RSP
good = b (inputs shrinked) - RWS

_

QUIZ 4.5
whichof the followingstatementsaretrue? (Chooseall
thatapply.)

a) IfRSP<RWSthentheamountofworkperformed
isdecreasingwiththerecursionlevelj.
b) IfRSP>RWSthentheamountofworkperformed
isincreasingwiththerecursionlevelj.
c)Noconclusionscanbedrawnabouthowtheamount
ofworkvarieswiththerecursionleveljunlessRSP=
RWS.
d) IfRSP=RWSthentheamountofworkperformed
isthesameateveryrecursionlevel.


ANSWER:
lets analyze this one by on
a. RSP < RWS basically
a < b
means that work is mostyl done at top level instead of root
since input shrinks more than subproblem spawing
im not sure what amount of work mean here but the root wins so i guess
when you go down amount of work is decreasing so thats techinically true?
RSP/RWS is < 1
1 -> 1/2 -> 1/4 ... so it decreases


b. RSP > RWS
a > b
so here the recursive calls overpower which means
leaves win, answer is mostly at the leave level
again not sure what amount of work means here
RSP / RWS is greater than 1
1 -> 2 -> 4 -> ... -> so total work per level increases

c. a = b
this is basically the tie case right
so the amount of work equals?

d. a = b agian so its like equal right?



|#


; ==========================
; when a > b, it creates/spawns more 'branches'
; when b > a, work done doesn't shrink fast enough to counteract new branches
; b = 'height' - depth -> bigger b shrinks n faster, making n shallow
; a = 'width' - branching -> bigger a spawns more subproblem, making tree wider
; ==========================