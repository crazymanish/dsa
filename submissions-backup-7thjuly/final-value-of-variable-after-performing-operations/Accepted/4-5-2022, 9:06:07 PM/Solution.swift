// https://leetcode.com/problems/final-value-of-variable-after-performing-operations

class Solution {
    func finalValueAfterOperations(_ operations: [String]) -> Int {
        var output = 0
        var operationIndex = 0
        
        while operationIndex < operations.count {
            let operation = operations[operationIndex]
            
            if operation == "++X" || operation == "X++" {
                output += 1
            } else if operation == "--X" || operation == "X--" {
                output -= 1
            }
            
            operationIndex += 1
        }
        
        return output
    }
}