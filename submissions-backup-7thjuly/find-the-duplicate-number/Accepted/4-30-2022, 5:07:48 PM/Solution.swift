// https://leetcode.com/problems/find-the-duplicate-number

class Solution {
    func findDuplicate(_ nums: [Int]) -> Int {
        var uniqueSet: Set<Int> = []
        var output = -1
        
        for num in nums {
            let isInserted = uniqueSet.insert(num).inserted
            
            if isInserted == false {
                output = num
                break
            }
        }
        
        return output
    }
}