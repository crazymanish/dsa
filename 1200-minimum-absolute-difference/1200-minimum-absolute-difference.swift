class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n log n)
    ///     - Sorting the array dominates the runtime.
    ///
    /// Space Complexity:
    ///   • O(n)
    ///     - Space used to store the result pairs.
    ///     (Sorting space ignored.)
    ///
    /// Problem Summary:
    ///   Given an array of distinct integers, find all pairs of elements
    ///   with the minimum absolute difference.
    ///
    /// Key Insight:
    ///   - After sorting, the minimum absolute difference must occur
    ///     between adjacent elements.
    ///   - We only need to compare neighboring pairs.
    /// -----------------------------------------------------------------------
    func minimumAbsDifference(_ arr: [Int]) -> [[Int]] {
        // Sort the array to bring closest values together
        let sortedValues = arr.sorted()
        
        var minimumDifference = Int.max
        var closestPairs = [[Int]]()
        
        // Compare adjacent elements
        for index in 0..<(sortedValues.count - 1) {
            let leftValue = sortedValues[index]
            let rightValue = sortedValues[index + 1]
            let difference = rightValue - leftValue
            
            if difference == minimumDifference {
                // Found another pair with the same minimum difference
                closestPairs.append([leftValue, rightValue])
            } else if difference < minimumDifference {
                // Found a smaller minimum difference; reset results
                minimumDifference = difference
                closestPairs = [[leftValue, rightValue]]
            }
        }
        
        return closestPairs
    }
}
