class Solution {
    /// -----------------------------------------------------------------------
    /// Problem Summary:
    ///   Sort integers by:
    ///     1. Number of set bits (ascending)
    ///     2. Value itself (ascending) if tie
    ///
    /// Strategy:
    ///   Use built-in `nonzeroBitCount` for efficient bit counting
    ///   and sort using a custom comparator.
    ///
    /// Time Complexity:
    ///   • O(n log n)
    ///     Single sort operation.
    ///
    /// Space Complexity:
    ///   • O(1) extra (ignoring sort internals).
    /// -----------------------------------------------------------------------
    func sortByBits(_ arr: [Int]) -> [Int] {
        return arr.sorted {
            let bitCountA = $0.nonzeroBitCount
            let bitCountB = $1.nonzeroBitCount
            
            // First sort by bit count
            if bitCountA != bitCountB {
                return bitCountA < bitCountB
            }
            
            // If tie, sort by numeric value
            return $0 < $1
        }
    }
}