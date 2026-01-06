#lang racket

#|
3.6.1 In how many ways can [1 . . n] be expressed as the concatenation of 
two non-empty lists?

answer:
small example, lets say the list is [1,2,3,4]
so it has 4 items

we can do
1. [1] ++ [2,3,4]
2. [1,2] ++ [3,4]
3. [1,2,3] ++ [4]

so thats 4-1 = 3 ways to represent concatenantion with nonemopty list

generally
first. [1] ++ [..n]
middle. whatever in-between values which can range
last. [1,2,..] ++ [n]

|#