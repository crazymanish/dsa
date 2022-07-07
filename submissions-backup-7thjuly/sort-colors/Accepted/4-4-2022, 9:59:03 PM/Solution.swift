// https://leetcode.com/problems/sort-colors

class Solution {
    func sortColors(_ nums: inout [Int]) {
        var hashMap = [0: 0, 1: 0, 2:0]
        
        for num in nums { hashMap[num] = hashMap[num]! + 1 }
        
        var index = 0
        for num in 0...2 {
            var hashMapValue = hashMap[num]!
            
            while hashMapValue > 0 {
                nums[index] = num

                index += 1
                hashMapValue -= 1
            }
        }
    }
}
