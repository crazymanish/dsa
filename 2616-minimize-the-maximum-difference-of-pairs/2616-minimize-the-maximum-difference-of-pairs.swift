// Time Complexity: O(n log n + n log D)
// O(n log n) is for the initial sorting of the array.
// O(n log D) is for the binary search, where 'n' is the number of elements,
// and 'D' is the difference between the maximum and minimum values in the array.
// The binary search performs O(log D) iterations, and each iteration involves a
// linear scan (O(n)) to count the number of pairs.

// Space Complexity: O(n)
// The space is dominated by the storage required for `sortedNumbers`, which is a sorted
// copy of the input array.
class Solution {
    /**
     * Finds the minimum possible value of the maximum difference among 'p' pairs.
     *
     * - Parameters:
     * - nums: An array of integers.
     * - p: The required number of pairs to form.
     * - Returns: The minimized maximum difference.
     */
    func minimizeMax(_ nums: [Int], _ p: Int) -> Int {
        // We need at least 2 * p elements to form p pairs.
        guard !nums.isEmpty, p > 0 else { return 0 }
        
        let numbersCount = nums.count
        let sortedNumbers = nums.sorted()
        
        // Binary search for the best possible answer. The answer must lie between 0
        // and the maximum possible difference in the array.
        var minPossibleDifference = 0
        var maxPossibleDifference = sortedNumbers.last! - sortedNumbers.first!
        
        var result = maxPossibleDifference
        
        while minPossibleDifference <= maxPossibleDifference {
            // `maxDifferenceThreshold` is the potential answer we are currently testing.
            let maxDifferenceThreshold = minPossibleDifference + (maxPossibleDifference - minPossibleDifference) / 2
            
            // Check if we can form at least `p` pairs where the difference of each pair
            // is no more than `maxDifferenceThreshold`.
            if canFormPairs(in: sortedNumbers, maxDifference: maxDifferenceThreshold, requiredPairs: p) {
                // This `maxDifferenceThreshold` is a valid potential answer.
                // We store it and try to find an even smaller one.
                result = maxDifferenceThreshold
                maxPossibleDifference = maxDifferenceThreshold - 1
            } else {
                // The threshold is too small to form `p` pairs. We need to allow a larger difference.
                minPossibleDifference = maxDifferenceThreshold + 1
            }
        }
        
        return result
    }
    
    /**
     * A helper function to greedily count how many non-overlapping pairs can be formed
     * with a difference less than or equal to a given maximum.
     */
    private func canFormPairs(in sortedNumbers: [Int], maxDifference: Int, requiredPairs: Int) -> Bool {
        var formedPairsCount = 0
        var currentIndex = 0
        
        while currentIndex < sortedNumbers.count - 1 {
            // If the difference between adjacent elements is within the allowed maximum...
            if sortedNumbers[currentIndex + 1] - sortedNumbers[currentIndex] <= maxDifference {
                // ...we form a pair and skip the next element since it's now used.
                formedPairsCount += 1
                currentIndex += 2
            } else {
                // Otherwise, we can't form a pair here, so we move to the next element.
                currentIndex += 1
            }
            
            // Early exit if we have already formed the required number of pairs.
            if formedPairsCount >= requiredPairs {
                return true
            }
        }
        
        return formedPairsCount >= requiredPairs
    }
}