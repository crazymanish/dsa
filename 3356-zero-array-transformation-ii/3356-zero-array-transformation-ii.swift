class Solution {
    func minZeroArray(_ nums: [Int], _ queries: [[Int]]) -> Int {
        if nums.isEmpty { return -1 }

        var minimumQueriesToZero = -1 // Initialize the result to -1 (no solution found yet)

        // Nested function to perform binary search on the number of queries
        func binarySearchQueries() {
            var leftQueryIndex = 0 // Left boundary for the binary search (start with 0 queries)
            var rightQueryIndex = queries.count // Right boundary for the binary search (maximum number of queries)

            // Nested function to check if the array can be made zero with a given number of queries
            func canMakeArrayZero(_ queryCount: Int) -> Bool {
                let arrayLength = nums.count // Get the length of the input array
                var decrementDeltas = [Int](repeating: 0, count: arrayLength + 1) // Initialize the difference array

                // Apply the first 'queryCount' queries to the difference array
                for queryIndex in 0 ..< queryCount {
                    let query = queries[queryIndex] // Get the current query
                    let leftRange = query[0] // Get the left range of the query
                    let rightRange = query[1] // Get the right range of the query
                    let decrementValue = query[2] // Get the decrement value of the query

                    decrementDeltas[leftRange] += decrementValue // Increment the decrement at the start of the range
                    decrementDeltas[rightRange + 1] -= decrementValue // Decrement the decrement after the end of the range
                }

                var cumulativeDecrement = 0 // Initialize the cumulative decrement
                // Check if each element can be reduced to zero
                for arrayIndex in 0 ..< arrayLength {
                    cumulativeDecrement += decrementDeltas[arrayIndex] // Calculate the cumulative decrement at the current index
                    if cumulativeDecrement < nums[arrayIndex] {
                        return false // If the cumulative decrement is not enough, the array cannot be zeroed
                    }
                }

                return true // All elements can be reduced to zero
            }

            // Perform the binary search
            while leftQueryIndex <= rightQueryIndex {
                let midQueryIndex = leftQueryIndex + (rightQueryIndex - leftQueryIndex) / 2 // Calculate the middle query index
                if canMakeArrayZero(midQueryIndex) { // Check if the array can be zeroed with 'midQueryIndex' queries
                    rightQueryIndex = midQueryIndex - 1 // If yes, try fewer queries
                    minimumQueriesToZero = midQueryIndex // Update the result
                } else {
                    leftQueryIndex = midQueryIndex + 1 // If no, try more queries
                }
            }
        }

        binarySearchQueries() // Call the nested binary search function
        return minimumQueriesToZero // Return the minimum number of queries needed, or -1 if none found
    }
}