class Solution {
    func maxDepth(_ s: String) -> Int {
        var result = 0
        var depth = 0
        
        for char in s {
            switch char {
                case "(": depth += 1
                case ")": depth -= 1
                default: break
            }
            
            result = max(result, depth)
        }
        
        return result
    }
}