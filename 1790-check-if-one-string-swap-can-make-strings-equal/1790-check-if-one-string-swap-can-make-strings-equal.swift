class Solution {
    func areAlmostEqual(_ s1: String, _ s2: String) -> Bool {
        // If the lengths are not equal, return false
        if s1.count != s2.count { return false }
        
        // Convert strings to arrays of characters for easy indexing
        let chars1 = Array(s1)
        let chars2 = Array(s2)
        
        // Initialize an array to store the indices where characters differ
        var differingIndices = [Int]()
        
        // Iterate through the strings to find differing indices
        for i in 0..<chars1.count {
            if chars1[i] != chars2[i] {
                differingIndices.append(i)
            }
        }
        
        // If there are no differences, the strings are already equal
        if differingIndices.isEmpty { return true }
        
        // If there are exactly two differences, check if swapping makes the strings equal
        if differingIndices.count == 2 {
            let i = differingIndices[0]
            let j = differingIndices[1]
            return chars1[i] == chars2[j] && chars1[j] == chars2[i]
        }
        
        // If there are more than two differences, return false
        return false
    }
}