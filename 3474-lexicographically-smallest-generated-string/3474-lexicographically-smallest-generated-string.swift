class Solution {
    /**
     Problem Summary:
     We are given two strings:
     - `pattern` (s): contains 'T' and 'F'
     - `target` (t): a string we want to enforce or avoid in certain positions
     
     We need to construct a resulting string such that:
     - For every index i where pattern[i] == 'T', the substring starting at i must equal `target`
     - For every index i where pattern[i] == 'F', the substring starting at i must NOT equal `target`
     
     If it's impossible, return an empty string.

     Strategy:
     1. Initialize a result array with '?' placeholders.
     2. Enforce all 'T' constraints by placing `target` at required positions.
        - If conflicts arise, return "".
     3. Fill remaining '?' with 'a' (default minimal character).
     4. For each 'F', check if the substring accidentally equals `target`.
        - If it does, modify one flexible position (previously '?') to break the match.
        - If no such modification is possible, return "".

     Time Complexity:
     O(n * m)
     - For each position in pattern, we may compare up to m characters

     Space Complexity:
     O(n + m)
     - Result array and input arrays
     */
    func generateString(_ pattern: String, _ target: String) -> String {
        let patternChars = Array(pattern)
        let targetChars = Array(target)
        
        let patternLength = patternChars.count
        let targetLength = targetChars.count
        
        // Final result length = n + m - 1
        var result = Array(repeating: Character("?"), count: patternLength + targetLength - 1)
        
        // Step 1: Enforce all 'T' constraints
        for startIndex in 0..<patternLength {
            guard patternChars[startIndex] == "T" else { continue }
            
            for offset in 0..<targetLength {
                let resultIndex = startIndex + offset
                let currentChar = result[resultIndex]
                let requiredChar = targetChars[offset]
                
                // If already assigned and conflicts → impossible
                if currentChar != "?" && currentChar != requiredChar {
                    return ""
                }
                
                // Assign required character
                result[resultIndex] = requiredChar
            }
        }
        
        // Preserve original state to track which positions were flexible ('?')
        let originalState = result
        
        // Step 2: Fill remaining '?' with default character 'a'
        for i in 0..<result.count {
            if result[i] == "?" {
                result[i] = "a"
            }
        }
        
        // Step 3: Handle 'F' constraints (must NOT match target)
        for startIndex in 0..<patternLength {
            guard patternChars[startIndex] == "F" else { continue }
            
            // Check if substring equals target
            var isMatch = true
            for offset in 0..<targetLength {
                if result[startIndex + offset] != targetChars[offset] {
                    isMatch = false
                    break
                }
            }
            
            // If already not equal → fine
            guard isMatch else { continue }
            
            // Otherwise, we must break the match
            var didModify = false
            
            // Try modifying from right to left (greedy safe choice)
            for index in stride(from: startIndex + targetLength - 1, through: startIndex, by: -1) {
                // Only modify positions that were originally flexible
                if originalState[index] == "?" {
                    result[index] = "b" // change to something different than 'a'
                    didModify = true
                    break
                }
            }
            
            // If no modification possible → impossible
            guard didModify else { return "" }
        }
        
        return String(result)
    }
}