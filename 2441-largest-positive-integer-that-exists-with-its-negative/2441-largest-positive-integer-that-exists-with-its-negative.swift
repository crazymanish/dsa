class Solution {
    func findMaxK(_ nums: [Int]) -> Int {
        var max = 0
        
        for num in nums {
            if nums.contains(-num) && num > max {
                max = num 
            }
        }
        
        return max == 0 ? -1 : max
    }
}