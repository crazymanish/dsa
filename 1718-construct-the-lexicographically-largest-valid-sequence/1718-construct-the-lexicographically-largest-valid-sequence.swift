class Solution {
    func constructDistancedSequence(_ n: Int) -> [Int] {
        let length = 2 * n - 1  // The required length of the sequence
        var sequence = Array(repeating: 0, count: length)  // Stores the final sequence
        var isUsed = Array(repeating: false, count: n + 1)  // Tracks whether a number is used

        // Helper function to backtrack and construct the sequence
        func backtrack(_ index: Int) -> Bool {
            // If we have filled the sequence completely, return true
            if index == length { return true }
            
            // If the current position is already filled, move to the next index
            if sequence[index] != 0 { return backtrack(index + 1) }
            
            // Try placing numbers from n down to 1 (larger numbers first for lexicographically larger sequence)
            for num in stride(from: n, to: 0, by: -1) where !isUsed[num] {
                if num == 1 {
                    // Special case: 1 only occupies one position
                    sequence[index] = 1
                    isUsed[1] = true

                    if backtrack(index + 1) { return true }

                    // Backtrack: undo changes
                    isUsed[1] = false
                    sequence[index] = 0
                } else if index + num < length, sequence[index + num] == 0 {
                    // If `num` fits at `index` and `index + num`, place it
                    sequence[index] = num
                    sequence[index + num] = num
                    isUsed[num] = true

                    if backtrack(index + 1) { return true }
                    
                    // Backtrack: undo changes
                    isUsed[num] = false
                    sequence[index] = 0
                    sequence[index + num] = 0
                }
            }
            
            return false  // No valid sequence found from this index
        }
        
        backtrack(0)  // Start backtracking from index 0
        return sequence  // Return the final sequence
    }
}
