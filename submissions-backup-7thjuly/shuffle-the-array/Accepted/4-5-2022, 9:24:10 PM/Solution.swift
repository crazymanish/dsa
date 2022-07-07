// https://leetcode.com/problems/shuffle-the-array

class Solution {
    func shuffle(_ nums: [Int], _ n: Int) -> [Int] {
        var output: [Int] = []
        
        var xPointer = 0
        var yPointer = n
        
        while xPointer < n {
            output.append(nums[xPointer])
            output.append(nums[yPointer])
            
            xPointer += 1
            yPointer += 1
        }
        
        return output
    }
}