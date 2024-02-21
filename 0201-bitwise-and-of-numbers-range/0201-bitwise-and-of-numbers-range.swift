class Solution {
    func rangeBitwiseAnd(_ left: Int, _ right: Int) -> Int {
        var left = left
        var right = right
        var shift = 0
        
        while left != right {
            left >>= 1
            right >>= 1
            
            shift += 1
        }
        
        return left << shift
    }
}