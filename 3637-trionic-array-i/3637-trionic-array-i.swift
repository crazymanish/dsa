class Solution {
    /// Represents the three required phases of a trionic array:
    ///   1. Strictly increasing
    ///   2. Strictly decreasing
    ///   3. Strictly increasing
    private enum TrionicPhase {
        case increasingFirst
        case decreasingMiddle
        case increasingLast
    }

    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n), where n = nums.count
    ///     We scan the array once.
    ///
    /// Space Complexity:
    ///   • O(1)
    ///     Only a constant number of variables are used.
    ///
    /// Problem Summary:
    ///   An array is trionic if it follows this exact pattern:
    ///
    ///       strictly increasing → strictly decreasing → strictly increasing
    ///
    ///   Each phase must have at least one element, and
    ///   adjacent elements must never be equal.
    ///
    /// Approach:
    ///   - Track which phase we are currently in.
    ///   - Move between phases when the comparison direction changes.
    ///   - Reject immediately if the pattern is violated.
    /// -----------------------------------------------------------------------
    func isTrionic(_ nums: [Int]) -> Bool {
        // A trionic array needs at least 3 elements
        guard nums.count >= 3 else { return false }
        
        // The first phase must start with a strict increase
        guard nums[0] < nums[1] else { return false }
        
        var phase = TrionicPhase.increasingFirst
        
        // Scan through the array once
        for index in 1..<nums.count {
            let previous = nums[index - 1]
            let current = nums[index]
            
            // Adjacent values must be strictly different
            if previous == current { return false }
            
            switch phase {
            case .increasingFirst:
                // Transition to decreasing phase when order flips
                if previous > current { phase = .decreasingMiddle }
                
            case .decreasingMiddle:
                // Transition to final increasing phase when order flips again
                if previous < current { phase = .increasingLast }
                
            case .increasingLast:
                // Must remain strictly increasing
                if previous > current { return false }
            }
        }
        
        // Valid only if we reached the final increasing phase
        return phase == .increasingLast
    }
}
