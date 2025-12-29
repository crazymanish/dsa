/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • Exponential in the worst case:
///       O(b^(n-1)) per level, where:
///         - n = length of the current row
///         - b = average number of allowed characters per pair
///   • Memoization significantly prunes repeated states.
///
/// Space Complexity:
///   • O(states * n)
///     - Memo stores results for previously seen rows
///     - Recursion depth is at most the height of the pyramid (≤ bottom length)
///
/// Problem Summary:
///   Given a bottom row and a list of allowed transitions:
///       XY -> Z
///   determine whether we can build a pyramid up to a single block.
///
/// Approach:
///   - Preprocess allowed transitions into a map:
///         [X, Y] → [Z1, Z2, ...]
///   - Use DFS with memoization on each row.
///   - For a given row, generate all possible next rows via backtracking.
///   - If any path reaches a single block, return true.
/// ---------------------------------------------------------------------------

class Solution {
    func pyramidTransition(_ bottom: String, _ allowed: [String]) -> Bool {
        
        // Build transition map: [bottomChar1, bottomChar2] → possible top characters
        var transitionMap = [[Character]: [Character]]()
        for rule in allowed {
            let pair = Array(rule.prefix(2))
            let topChar = rule.last!
            transitionMap[pair, default: []].append(topChar)
        }
        
        // Memoization: row → whether it can lead to a valid pyramid
        var memo = [[Character]: Bool]()
        
        // DFS to determine if a given row can reach the top
        func canBuildPyramid(from row: [Character]) -> Bool {
            // Base case: reached the top
            if row.count == 1 { return true }
            
            // Return cached result if already computed
            if let cached = memo[row] {
                return cached
            }
            
            // Collect possible characters for each position in the next row
            var nextRowOptions = [[Character]]()
            
            for i in 0..<(row.count - 1) {
                let pair = [row[i], row[i + 1]]
                
                // If no transition exists, this path is invalid
                guard let options = transitionMap[pair] else {
                    memo[row] = false
                    return false
                }
                
                nextRowOptions.append(options)
            }
            
            // Try building all possible next rows
            let result = buildNextRow(nextRowOptions, index: 0, current: [])
            memo[row] = result
            return result
        }
        
        // Backtracking to generate next-row combinations
        func buildNextRow(
            _ options: [[Character]],
            index: Int,
            current: [Character]
        ) -> Bool {
            // Completed a full next row
            if index == options.count {
                return canBuildPyramid(from: current)
            }
            
            // Try each possible character at this position
            for char in options[index] {
                if buildNextRow(options, index: index + 1, current: current + [char]) {
                    return true
                }
            }
            
            return false
        }
        
        return canBuildPyramid(from: Array(bottom))
    }
}
