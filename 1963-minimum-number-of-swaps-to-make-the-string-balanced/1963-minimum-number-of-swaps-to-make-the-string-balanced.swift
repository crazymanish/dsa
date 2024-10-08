class Solution {
    func minSwaps(_ s: String) -> Int {
        var depth = 1 // nesting depth, floor is now 1.
        
        for char in s {
            depth += (char == "[" || depth == 1) ? 1 : -1
        }

        return depth/2
    }
}