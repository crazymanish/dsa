class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(m * n)
    ///     - m = number of rows
    ///     - n = number of columns
    ///     We scan every element once.
    ///
    /// Space Complexity:
    ///   • O(m * n)
    ///     - Due to flattening the matrix into a single array.
    ///     (Can be reduced to O(1) with a single pass if desired.)
    ///
    /// Problem Summary:
    ///   You may flip the sign of any element any number of times,
    ///   but only in pairs (effectively allowing sign changes).
    ///   The goal is to maximize the sum of the matrix.
    ///
    /// Key Insight:
    ///   - The maximum possible sum is the sum of absolute values.
    ///   - If the number of negative elements is EVEN, we can flip
    ///     all negatives to positive.
    ///   - If the number of negatives is ODD, one element must remain
    ///     negative — we should choose the smallest absolute value.
    /// -----------------------------------------------------------------------
    func maxMatrixSum(_ matrix: [[Int]]) -> Int {
        // Flatten the matrix into a single list of values
        let allValues = matrix.flatMap { $0 }
        
        // Compute absolute values
        let absoluteValues = allValues.map { abs($0) }
        
        // Sum of all absolute values
        let absoluteSum = absoluteValues.reduce(0, +)
        
        // Count how many values are negative
        let negativeCount = allValues.filter { $0 < 0 }.count
        
        // If negatives are even, all can be made positive
        if negativeCount.isMultiple(of: 2) {
            return absoluteSum
        }
        
        // Otherwise, one value must stay negative —
        // subtract twice the smallest absolute value
        let smallestAbsoluteValue = absoluteValues.min()!
        return absoluteSum - 2 * smallestAbsoluteValue
    }
}
