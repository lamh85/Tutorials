```
https://www.techiedelight.com/longest-increasing-subsequence-using-dynamic-programming/

Solutions:
0, 2, 6, 9, 11, 15
0, 4, 6, 9, 11, 15
0, 4, 6, 9, 13, 15

Input =
0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15
```

 0| 8| 4|12| 2|10| 6|14| 1| 9| 5|13| 3|11| 7|15
--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--
 1| 1| 1| 1| 1| 1| 1| 1| 1| 1| 1| 1| 1| 1| 1| 1
 1| 2| 2| 3| 2| 3| 3| 5| 2| 4| 3| 5| 3| 5| 4| 6

An subset containing 15 has more elements than any other subset. Such subset has 6.