#lang racket

#|
4-35. [5] Let M be an n×m integer matrix in which the entries of each row are sorted in
increasing order (from left to right) and the entries in each column are in increasing
order (from top to bottom). Give an efficient algorithm to find the position of an
integer x in M,ortodeterminethatx is not there. How many comparisons of x
with matrix entries does your algorithm use in worst case?


if m is smaller than top right corner
then its to the lft

if its larger than top right corner
then its below

total = m + n comparison
|#


matrix