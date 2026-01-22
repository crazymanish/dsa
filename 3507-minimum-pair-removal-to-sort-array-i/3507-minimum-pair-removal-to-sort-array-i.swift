class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • Worst case: O(n²)
    ///     Each operation scans the entire array to:
    ///       - check if it is non-decreasing
    ///       - find the adjacent pair with minimum sum
    ///     There can be up to (n - 1) merge operations, and each scan is O(n).
    ///
    /// Space Complexity:
    ///   • O(n)
    ///     We maintain a mutable copy of the input array.
    ///
    /// Problem Summary:
    ///   Repeatedly merge (replace) the adjacent pair with the minimum sum
    ///   until the array becomes non-decreasing. Return the number of merges.
    ///
    /// Approach:
    ///   - While the array is not non-decreasing:
    ///       • Find the adjacent pair with the smallest sum.
    ///       • Merge it (sum into the left element) and remove the right element.
    /// -----------------------------------------------------------------------
    func minimumPairRemoval(_ nums: [Int]) -> Int {
        var workingArray = nums
        var operationCount = 0
        
        while true {
            var isNonDecreasing = true
            var smallestPairSum = Int.max
            var mergeLeftIndex = -1
            
            // Scan adjacent pairs:
            // 1) detect if array is already non-decreasing
            // 2) choose the pair with minimum sum to merge
            for (pairIndex, (leftValue, rightValue)) in workingArray.adjacentPairs().enumerated() {
                if leftValue > rightValue {
                    isNonDecreasing = false
                }
                
                let pairSum = leftValue + rightValue
                if pairSum < smallestPairSum {
                    smallestPairSum = pairSum
                    mergeLeftIndex = pairIndex
                }
            }
            
            // Stop once the array is sorted (non-decreasing)
            if isNonDecreasing { break }
            
            // Merge the selected adjacent pair:
            // replace workingArray[mergeLeftIndex] with the sum of the pair
            // and remove the right element
            operationCount += 1
            workingArray[mergeLeftIndex] += workingArray[mergeLeftIndex + 1]
            workingArray.remove(at: mergeLeftIndex + 1)
        }
        
        return operationCount
    }
}
