Do you need to know algorithms for frontend development?
https://www.reddit.com/r/Frontend/comments/3euhau/do_you_need_to_know_algorithms_for_frontend/
  Best response:
  https://www.reddit.com/r/Frontend/comments/3euhau/do_you_need_to_know_algorithms_for_frontend/ctikdsp

https://towardsdatascience.com/top-algorithms-and-data-structures-you-really-need-to-know-ab9a2a91c7b5

Topics suggested by Facebook:
https://mail.google.com/mail/u/0/#search/adriana/FMfcgxwBVWJSSqgZhZJBFRKdTVFLMWpq
Algorithms:
- Merge Sort
- Quick Sort
- Breadth-first search
- Depth-first search
- Binary Search
Data Structures:
- Arrays/ArrayLists
- Hash Tables
- Trees - EG: binary trees
- Graphs
- Stacks/Queues
- Heaps
Concepts:
- Big O
- Recursion
- Memoization/Dynamic Programming
Design patterns

Big O Notation
  Javascript examples
  https://medium.com/cesars-tech-insights/big-o-notation-javascript-25c79f50b19b
  Ruby examples
  https://blog.honeybadger.io/a-rubyist-s-guide-to-big-o-notation/

How to read the notation:
For example: O(1)
The "O" is just the name of the function. EG: "O of 1".
The evaluation of the parenthesis is the number of iterations.
In the above example, the result will always be one iteration.

Goal: minimize the number of iterations.

What is a logorithm?
It solves for the mystery exponent, with the default base of 10.
EG: log100 = 2
Since the base is not defined, the base is 10. The answer is 2 because 10 requires that exponent to produce 100.
EG: "base 2 logorithm of 8" = 3
Because 2 must be cubed to become 8.
The above is equivalent of dividing two base-10 logorithms: log8 / log2 = 3

N = number of elements.
EG: O(N) = number of iterations grows linearly with the number of elements

Binary Trees (big takeaways)
============

Everything on the right is bigger than everything on the left.
Same for vice versa.

An optimized tree (AVL tree) creates the best Big O performance for search: O * LogN

Pivoting:
---------

  10
/     \
1     20
      |   \
      15    30
              \
                40

1. Find the node that would create the best balance if it becomes the new root. "20" is the answer: 2 on the left (1 and 10), 2 on the right (30 and 40), and 1 stragler (15).
2. The straggler is re-inserted. The result: 15 becomes the right child of 10.
- We know that everything to the right of 10 is greater than 10.
- Therefore, if we re-insert 15, it will be the right child of 10.

Graphs
======

https://medium.freecodecamp.org/a-gentle-introduction-to-data-structures-how-graphs-work-a223d9ef8837