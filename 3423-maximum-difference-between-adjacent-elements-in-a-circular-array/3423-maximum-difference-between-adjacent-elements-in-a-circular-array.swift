// Time Complexity: O(n)
// The code iterates through the input array once, performing a constant
// number of operations for each element. 'n' is the number of elements in the array.

// Space Complexity: O(1)
// The algorithm uses a fixed amount of extra space regardless of the input size.
class Solution {
    /**
     * Calculates the maximum absolute difference between adjacent elements in a circular array.
     * In a circular array, the last element is considered adjacent to the first element.
     *
     * - Parameter nums: An array of integers.
     * - Returns: The maximum adjacent distance. Returns 0 if the array has fewer than 2 elements.
     */
    func maxAdjacentDistance(_ numbers: [Int]) -> Int {
        let count = numbers.count
        
        // The concept of adjacent distance requires at least two elements.
        guard count > 1 else { return 0 }
        
        // Initialize the maximum difference found so far to zero.
        var maxDifference = 0
        
        // Iterate through each element in the array to compare it with its next neighbor.
        for currentIndex in 0..<count {
            // The `% count` operation ensures the array wraps around,
            // making the last element adjacent to the first.
            let nextIndex = (currentIndex + 1) % count
            
            // Calculate the absolute difference between the current element and its neighbor.
            let currentDifference = abs(numbers[currentIndex] - numbers[nextIndex])
            
            // Update the maximum difference if the current one is larger.
            maxDifference = max(maxDifference, currentDifference)
        }
        
        return maxDifference
    }
}