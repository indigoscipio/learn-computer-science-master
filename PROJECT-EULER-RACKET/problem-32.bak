#lang racket

#|
PROBLEM 31
COIN SUMS

in the uk the currency is made up of pound (£) and pence (p)
there are eight coins in general circualtion

1p, 2p, 5p, 10p, 20p, 50p, 1gbp (100p), and 2gbp (200p)

it is possible to make 2gbp in the following way
1 x 1gbp + 1 x 50p + 2x20p + 1x5p + 1x2p + 3x1p

how many different ways can 2gbp be made using any number of coins?

answer:

ok i feel like ive encountered this problem before but i dont remmeber exactly
how to tackle it, something with permutations or factorials or something i dont remmeber

does gbp and pence differentiation matter? we can just group it in pence
since 1gbp = 100p

the question askshow many idfferent ways 2gbp (200p) can be made using any number of coins
let me understand the problem and maybe simplify the problem
how many ways 1p can be made using any number of coins?
1p -> 1p (1 way)
2p -> 1p + 1p, 2p (2 way)
5p -> 1p+1p+1p+1p+1p, 2p+2p+1p, 2p+1p+1p+1p, 5p (4 way)
does 0p count? maybe not here lets assume it doesnt count
so its like asking for unique combinations? so order doesnt matter. 2p+2p+1p = 1p+2p+2p

approach
- helper that generate how many combination fit for one coin
- then call this on the outer loop
- we just need the diffrerent ways so list -> number at the end


given an amount remaining, and the coins still available to use
how many ways can you fill it?

Ask yourself this smaller question first:
if you could only use 1p coins, how many ways are
there to make any amount? Then: if you add 2p coins to your options,
how does that change things? See if you notice a pattern building up.

1p -> lets say amount is 5
1+1+1+1+1 so 1 way
amount is 10
1+1+...+1 its always 1 way with just 1 1 coin

but if we add 2p then it becomes a group
1+1+2
2+2+1
1+1+1+2
1+1+1+1+1...

When you're trying to make amount with a list of coins,
what are the only two choices you have
regarding the first coin in your list? Think about it in terms of:
what can you do with that coin?
Once you see those two choices clearly, ask yourself:
after each choice, what does the remaining problem look like?
Is it a smaller version of the same problem?

|#

; given a spending value n and coin type, calculates how many coin it can fit
; number number -> number
(define (how-many-ways amount coins)
  ; branch choice -> first coin -> use it or dont use it
  ; after each choice eventually amount will be less than or equal zero
  ; and eventually the coins chosen will be empty
  (cond [(= amount 0) 1]
        [(< amount 0) 0]
        [(null? coins) 0]
        [else (+ (how-many-ways (- amount (car coins)) coins) ; use first coin
                 (how-many-ways amount (cdr coins) ) ; skip first coin
                 )] 
        )
  )
(how-many-ways 5 '(1)); how many ways to spend 5p from just 1p?
(how-many-ways 5 '(1 2)); how many ways to spend 5p from  1p and 2p?

; main function
(define (coin-sums amount coins)
  (how-many-ways amount coins)
  )
(coin-sums 200 '(1 2 5 10 20 50 100 200))

