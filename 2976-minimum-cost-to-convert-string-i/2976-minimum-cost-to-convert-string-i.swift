class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(26³ + n)
    ///     - Floyd–Warshall runs on a fixed 26×26 matrix → constant time
    ///     - n = source.count (final pass over the strings)
    ///
    /// Space Complexity:
    ///   • O(26²)
    ///     - Distance matrix for all character transformations
    ///
    /// Problem Summary:
    ///   Given two strings `source` and `target` of equal length,
    ///   transform `source` into `target` character by character.
    ///
    ///   Each transformation:
    ///     original[i] → changed[i] costs cost[i]
    ///
    ///   You may chain transformations.
    ///   Find the minimum total cost, or return -1 if impossible.
    ///
    /// Approach:
    ///   - Model characters ('a' to 'z') as nodes in a graph.
    ///   - Edge weights represent transformation costs.
    ///   - Use Floyd–Warshall to compute the minimum cost between
    ///     every pair of characters.
    ///   - Sum the costs for transforming source → target.
    /// -----------------------------------------------------------------------
    func minimumCost(
        _ source: String,
        _ target: String,
        _ original: [Character],
        _ changed: [Character],
        _ costs: [Int]
    ) -> Int {

        let INF = Int.max / 2
        let alphabetSize = 26
        
        // minCostMatrix[i][j] = minimum cost to transform character i → j
        var minCostMatrix = Array(
            repeating: Array(repeating: INF, count: alphabetSize),
            count: alphabetSize
        )

        // Cost to transform a character to itself is zero
        for charIndex in 0..<alphabetSize {
            minCostMatrix[charIndex][charIndex] = 0
        }

        // Initialize direct transformation costs
        for i in 0..<original.count {
            let fromIndex = Int(original[i].asciiValue! - Character("a").asciiValue!)
            let toIndex   = Int(changed[i].asciiValue!  - Character("a").asciiValue!)
            let transformCost = costs[i]
            
            minCostMatrix[fromIndex][toIndex] =
                min(minCostMatrix[fromIndex][toIndex], transformCost)
        }

        // Floyd–Warshall: compute all-pairs minimum transformation costs
        for intermediate in 0..<alphabetSize {
            for from in 0..<alphabetSize {
                for to in 0..<alphabetSize {
                    let viaIntermediate =
                        minCostMatrix[from][intermediate] +
                        minCostMatrix[intermediate][to]
                    
                    if viaIntermediate < minCostMatrix[from][to] {
                        minCostMatrix[from][to] = viaIntermediate
                    }
                }
            }
        }

        // Compute total cost to transform source → target
        var totalTransformationCost = 0
        
        for (sourceChar, targetChar) in zip(source, target) {
            let fromIndex = Int(sourceChar.asciiValue! - Character("a").asciiValue!)
            let toIndex   = Int(targetChar.asciiValue! - Character("a").asciiValue!)
            
            // If transformation is impossible, return -1
            if minCostMatrix[fromIndex][toIndex] >= INF {
                return -1
            }
            
            totalTransformationCost += minCostMatrix[fromIndex][toIndex]
        }

        return totalTransformationCost
    }
}
