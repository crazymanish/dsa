final class Solution {
    /*
     Time Complexity: O(n)
     - Each character in the string is visited exactly once.
     
     Space Complexity: O(n)
     - Converting the string to an array of characters.
     (Can be reduced to O(1) if iterating directly over the string.)
    */
    
    func maxOperations(_ s: String) -> Int {
        var countOfOnes = 0   // Counts how many '1's we have seen so far
        var operationCount = 0
        let chars = Array(s)
        
        for i in 0..<chars.count {
            if chars[i] == "1" {
                countOfOnes += 1
            } else if i > 0 && chars[i - 1] == "1" {
                // Each "10" transition contributes 'countOfOnes' operations
                operationCount += countOfOnes
            }
        }
        
        return operationCount
    }
}
