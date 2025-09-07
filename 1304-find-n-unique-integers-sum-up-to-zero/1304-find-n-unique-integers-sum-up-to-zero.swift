// Time Complexity: O(N)
// The algorithm iterates from 1 up to N-1 to construct the array. The number of
// operations is directly proportional to N.
//
// Space Complexity: O(N)
// The function is required to create and return an array of size N. The space
// used is therefore proportional to N. (This is often considered O(1) auxiliary space
// if the space for the output array is not counted).
class Solution {
    /**
     * Constructs an array of `n` unique integers that sum up to zero.
     *
     * The strategy is to populate the first `n-1` elements of the array with the
     * unique positive integers `1, 2, ..., n-1`. We then calculate their sum.
     * The final, n-th element is simply the negation of this sum, which guarantees
     * the total sum of all `n` elements is zero.
     *
     * Uniqueness is guaranteed because the first `n-1` elements are positive, while
     * the final element is negative (for n > 1).
     *
     * - Parameter n: The desired number of unique integers.
     * - Returns: An array of `n` unique integers that sum to 0.
     */
    func sumZero(_ n: Int) -> [Int] {
        // Handle the edge case for n=1 separately for clarity, though the main logic also works.
        if n == 1 { return [0] }
        
        var result = [Int]()
        result.reserveCapacity(n) // Pre-allocate capacity for efficiency.
        
        var runningSum = 0
        
        // Add the first n-1 unique positive integers.
        for i in 1..<n {
            result.append(i)
            runningSum += i
        }
        
        // Add the final element, which is the negative of the sum of the others.
        result.append(-runningSum)
        
        return result
    }
}