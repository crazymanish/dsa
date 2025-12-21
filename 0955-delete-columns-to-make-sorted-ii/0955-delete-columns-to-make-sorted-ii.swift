/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n * m)
///     - n = number of strings
///     - m = length of each string
///     Each column is processed once, and each string index is moved
///     between tie-groups a constant number of times.
///
/// Space Complexity:
///   • O(n)
///     - We store indices grouped by identical prefixes.
///
/// Problem Summary:
///   We want to delete the minimum number of columns so that the remaining
///   strings are sorted lexicographically.
///
/// Core Idea:
///   - Process columns from left to right.
///   - Maintain "tie groups": groups of string indices that are still equal
///     under all previously kept columns.
///   - For each new column:
///       • If any tie group becomes decreasing, the column must be deleted.
///       • Otherwise, refine the tie groups by splitting them using the
///         current column character.
/// ---------------------------------------------------------------------------

class Solution {
    func minDeletionSize(_ strs: [String]) -> Int {
        // Convert strings to arrays of Characters for O(1) indexing
        let chars = strs.map { Array($0) }
        let n = chars.count
        let m = chars[0].count
        
        var deletedColumns = 0
        
        // tieGroups maps a prefix → list of string indices that share it
        // Initially, all strings are tied with an empty prefix
        var tieGroups: [String: [Int]] = ["": Array(0..<n)]
        
        // Process each column from left to right
        for col in 0..<m {
            var mustDelete = false
            
            // Step 1: Check if this column breaks lexicographic order
            for indices in tieGroups.values where indices.count > 1 {
                for (i1, i2) in indices.adjacentPairs() {
                    if chars[i1][col] > chars[i2][col] {
                        mustDelete = true
                        break
                    }
                }
                if mustDelete { break }
            }
            
            // If column is invalid, delete it and move on
            if mustDelete {
                deletedColumns += 1
                continue
            }
            
            // Step 2: Refine tie groups by splitting on current column character
            var nextTieGroups = [String: [Int]]()
            for (prefix, indices) in tieGroups {
                for i in indices {
                    let newPrefix = prefix + String(chars[i][col])
                    nextTieGroups[newPrefix, default: []].append(i)
                }
            }
            
            tieGroups = nextTieGroups
        }
        
        return deletedColumns
    }
}
