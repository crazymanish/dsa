class Solution {
    func minOperations(_ logs: [String]) -> Int {
        var depth = 0
        
        for operation in logs {
            switch operation {
                case "../": if depth > 0 { depth -= 1 }
                case "./": continue
                default: depth += 1 
            }
        }
        
        return depth
    }
}