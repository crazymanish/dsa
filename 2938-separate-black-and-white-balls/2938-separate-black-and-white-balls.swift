class Solution {
    func minimumSteps(_ s: String) -> Int {
        var left = 0, swaps = 0 
        
        for (right, ch) in zip(0..., s) where ch == "0" {
            swaps += right - left
            left += 1
        }
        
        return swaps
    }
}