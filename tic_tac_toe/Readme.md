# Technical Design

# Goal
Detect every possible way of winning.

How to win the game:
* 3 across - 3 variations
* 3 down - 3 variations
* diagonal - 2 variations

# Flow

Player makes a turn.
<br/>Game checs if there is a winner.

# Data Structure

Each squre has x and y coordinates.
```
[1,1] [1,2] [1,3]
[2,1] [2,2] [2,3]
[3,1] [3,2] [3,3]
```

Across Victory = same X coordinates
<br/>Down Victory = same Y coordinates
<br/>Diagonal Victory = coordinates sum == 4 || X coordinate == Y coordinate

## How to scale to a 4x4 grid
The Across and Down victories retain the same rules.

The Diagonal victory must now use a more robust logic. In the 3x3 grid, the rule `sum == 4` rule worked, but not in this case.

Now the sum must be 5 with these markings:
```
[1,4]
[2,3]
[3,2]
[3,1]
```

The 3x3 and 4x4 diagonal-sum rule have two traits in common:
1. The Y coordinate of the first row is the length of the grid.
2. The X coordinate of the first row is 1.
```
3x3 grid => [1,3]
4x4 grid => [4,1]
5x5 grid => [5,1]
```

Let's also check the required sum for each grid size:
```
3x3 grid => sum is 4:
[1,3] [2,2] [3,1]

4x4 grid => sum is 5:
[1,4] [2,3] [3,2] [4,1]

5x5 grid => sum is 6:
[1,5] [2,4] [3,3] [4,2] [5,1]
```

Therefore, the is always:
<br/>**Grid length + 1**

# Victory Rules

* The number of squares in a line is equal to the grid's length. EG: In a 3x3 grid, the line must have 3 squares.
* The squares in the line must have the same X coordinate.
* OR have the same Y coordinates
* OR each of its squares have the X coordinate same as Y coordinate
* OR each of its squares have coordinates summing to (grid length + 1)