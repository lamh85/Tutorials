# Recommended While Rearching

Do you need to know algorithms for frontend development?
https://www.reddit.com/r/Frontend/comments/3euhau/do_you_need_to_know_algorithms_for_frontend/
* Best response:
  https://www.reddit.com/r/Frontend/comments/3euhau/do_you_need_to_know_algorithms_for_frontend/ctikdsp

https://towardsdatascience.com/top-algorithms-and-data-structures-you-really-need-to-know-ab9a2a91c7b5

Why learn about algorithms?
* https://medium.com/@felipernb/algorithms-data-structures-and-web-development-7772e088f1d3

Algorithmic paradigms
* https://softwareengineering.stackexchange.com/a/309218

# Recommended by Facebook

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

# Big O

Javascript examples
https://medium.com/cesars-tech-insights/big-o-notation-javascript-25c79f50b19b

Ruby examples
https://blog.honeybadger.io/a-rubyist-s-guide-to-big-o-notation/

## How to read the notation

For example: O(1)
The "O" is just the name of the function. EG: "O of 1".
The evaluation of the parenthesis is the number of iterations.
In the above example, the result will always be one iteration.

Goal: minimize the number of iterations.

N = number of elements.
* EG: O(N) = number of iterations grows linearly with the number of elements

## What is a logorithm?

It solves for the mystery exponent, with the default base of 10.

EG: log100 = 2
* Since the base is not defined, the base is 10. The answer is 2 because 10 requires that exponent to produce 100.

EG: "base 2 logorithm of 8" = 3
* Because 2 must be cubed to become 8.
The above is equivalent of dividing two base-10 logorithms: log8 / log2 = 3

Binary Trees (big takeaways)
============

Everything on the right is bigger than everything on the left.
Same for vice versa.

An optimized tree (AVL tree) creates the best Big O performance for search: O * LogN

Pivoting:
---------

```
  10
/     \
1     20
      |   \
      15    30
              \
                40
```

1. Find the node that would create the best balance if it becomes the new root. "20" is the answer: 2 on the left (1 and 10), 2 on the right (30 and 40), and 1 stragler (15).
2. The straggler is re-inserted. The result: 15 becomes the right child of 10.
- We know that everything to the right of 10 is greater than 10.
- Therefore, if we re-insert 15, it will be the right child of 10.

Graphs
======

https://medium.freecodecamp.org/a-gentle-introduction-to-data-structures-how-graphs-work-a223d9ef8837

Finding the shortest distance
* https://medium.com/basecs/finding-the-shortest-path-with-a-little-help-from-dijkstra-613149fbdc8e

Lessons from Dijsktra strategy:
* The more secondary data you store, the easier is the algorithm. The Dijkstra method stored this additional data: the best path for the node, the previous node in the respective best path.
* A large discovery could produce smaller discoveries.
* Create a `stack` data structure.

Problems that Dijkstra solve:
* O(N^M)

Lessons from the data structure:
* The diagram does not have to be proportional.
* The diagram's main purpose is to understand which nodes are related.
* Any data structure can be used to describe relationship because all data structures require nodes and edges. EG: 2 neighbouring array items are related.

## Dijkstra Technical Design

Create table of three columns:

|Node | Shortest from A | Previous Node|
------|-----------------|--------------|
|A | Infinity | null |
|B | Infinity | null |
|etc...|

Create a list of unvisited nodes:
```javascript
const unvisitedMaster = [A, B, C, D, E]
```
Iterate:
```javascript
// Start with default node
const currentNode = unvisitedMaster[0]

// Identify the neighbours
const neighbours = getNeighbours(currentNode)

// Update the shortest path for all the neighbours
batchUpdateShortest(neighbours, currentNode)

// Remove the current node from the list of unvisited nodes
deleteFromUnvisitedMaster(currentNode)

// Move the cursor to the next node
const currentNode = getClosestNeighbour(currentNode)
```

# Heap

https://brilliant.org/wiki/heaps/

A binay tree where the root is either minimum or maximum.

In a maximum, every parent is greater than its children.

How to remove a node:
* http://www.mathcs.emory.edu/~cheung/Courses/171/Syllabus/9-BinTree/heap-delete.html

Uses:
* Easy to find the minimum or maximum.
* Easy to find the 2nd smallest or 2nd largest: just traverse down the tree.

# Sorting

Animated comparison
* https://miro.medium.com/max/899/1*bPpvELo9_QqQsDz7CSbwXQ.gif

# Quick Sort
https://brilliant.org/wiki/sorting-algorithms/

Create a pivot point in an array

```
7 5 2 3 6 8 1
      P
```

Then ensure that the left sub-array is less than the pivot, and the right sub-array is more than the pivot. Do this one by one.

```
1 5 2 3 6 8 7
*     P     * <= These numbers swapped
```

# Breadth First Search

Graphical demo
https://www.hackerearth.com/ja/practice/algorithms/graphs/breadth-first-search/tutorial/