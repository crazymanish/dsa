/*
Time Complexity Analysis:
1.  `flatMap` and `Dictionary` creation:
    * `flatMap` iterates through `queries` (Q items) and creates two tuples per query. This is O(Q).
    * Creating the `Dictionary` from these tuples involves hashing and insertion. In the worst case, if all start/end points are unique, it takes O(Q) average time. If hash collisions are frequent, it could degenerate, but for integer keys, this is usually efficient.
    * Overall: O(Q)

2.  `allSatisfy` loop:
    * Iterates `originalArray.count` (N items) times.
    * Inside the loop, dictionary lookup (`deltaPoints[index, default: 0]`) is O(1) on average.
    * Overall: O(N)

Combining these, the total Time Complexity is O(N + Q).

Space Complexity Analysis:
1.  `deltaPoints` dictionary:
    * In the worst case, each query `[l, r, val]` adds two unique keys (`l` and `r+1`) to the dictionary.
    * Therefore, the dictionary can store up to 2 * Q key-value pairs.
    * Overall: O(Q)

2.  Other variables: `originalArray`, `decrementQueries` are inputs (not counted for auxiliary space). `currentCumulativeDecrement`, `allElementsCanBeZero` are O(1).

Combining these, the total Auxiliary Space Complexity is O(Q).
*/
class Solution {
    func isZeroArray(_ originalArray: [Int], _ decrementQueries: [[Int]]) -> Bool {
        // Time: O(Q) for flatMap, where Q is the number of queries.
        // Space: O(Q) in the worst case for the Dictionary (if all query ranges are distinct).
        // Create a difference array from the queries.
        // For each query [start_idx, end_idx, value], we record:
        // +value at start_idx (this amount of decrement starts here)
        // -value at end_idx + 1 (this amount of decrement stops affecting elements from here)
        let deltaPoints: [Int: Int] = Dictionary(
            decrementQueries.flatMap { query in
                let startIndex = query[0]
                let endIndex = query[1]
                return [(startIndex, 1), (endIndex + 1, -1)]
            },
            // If multiple queries affect the same point, sum their delta values.
            uniquingKeysWith: +
        )

        var currentCumulativeDecrement = 0 // Tracks the total decrement applied up to the current index.
                                           // This is equivalent to the prefix sum of the deltaPoints.

        // Time: O(N) for iterating through the original array.
        // Space: O(1) extra space within this loop.
        // Iterate through the original array to check if each element can be made zero
        // by the cumulative decrements from the queries.
        let allElementsCanBeZero = originalArray.indices.allSatisfy { index in
            // Add any delta value from the difference array at the current index.
            // If an index has no recorded delta, 'default: 0' ensures it adds nothing.
            currentCumulativeDecrement += deltaPoints[index, default: 0]

            // Check if the current cumulative decrement is sufficient to make the originalArray[index] zero.
            // If the total decrement applied up to 'index' is less than the original value,
            // it's impossible to make this element (and thus the array) zero.
            return currentCumulativeDecrement >= originalArray[index]
        }

        return allElementsCanBeZero
    }
}