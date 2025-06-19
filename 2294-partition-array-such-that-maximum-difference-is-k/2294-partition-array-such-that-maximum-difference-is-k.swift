// Time Complexity: O(n log n)
// The complexity is dominated by the initial sorting of the array, which takes O(n log n) time.
// The single pass through the array after sorting takes O(n) time.
//
// Space Complexity: O(n) or O(log n)
// The space complexity depends on the implementation of the sort algorithm.
// If the `sorted()` method creates a new array (which is typical in Swift), the space is O(n).
// If the sort were done in-place, the space complexity would be O(log n) to O(1).
class Solution {
    /// Calculates the minimum number of partitions (subsequences) an array can be divided into,
    /// such that the difference between the maximum and minimum elements in each partition is no more than k.
    ///
    /// - Parameters:
    ///   - numbers: An array of integers.
    ///   - maxDifference: The maximum allowed difference (k) between elements in a single partition.
    /// - Returns: The minimum number of partitions required.
    func partitionArray(_ numbers: [Int], _ maxDifference: Int) -> Int {
        // Sort the array to process numbers in increasing order.
        // This allows a greedy approach where we can form partitions with the smallest possible starting elements.
        let sortedNumbers = numbers.sorted()
        
        // Tracks the maximum value the current partition can include.
        // It's initialized to a value lower than any possible element to ensure the first element starts a new partition.
        var partitionLimit = -1 
        
        // Counts the number of partitions created.
        var partitionCount = 0
        
        // Iterate through each number in the sorted array.
        for number in sortedNumbers {
            // If the current number is greater than the limit of the current partition,
            // it cannot be included. Therefore, a new partition must begin with this number.
            if number > partitionLimit {
                // A new partition is needed, so we increment the count.
                partitionCount += 1
                
                // Set the limit for this new partition. Since 'number' is the smallest element
                // in this new partition (due to sorting), the maximum element can be 'number + maxDifference'.
                partitionLimit = number + maxDifference
            }
            // If the number is within the current partition's limit (number <= partitionLimit),
            // it can be included, and we simply move to the next number without any action.
        }
        
        return partitionCount
    }
}