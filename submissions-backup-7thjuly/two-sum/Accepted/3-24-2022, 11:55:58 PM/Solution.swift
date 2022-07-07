// https://leetcode.com/problems/two-sum

class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var hashMap: [Int : Int] = [:]
        var output: [Int] = []
        
        var index = 0
        for num in nums {
            if let remainingTargetIndex = hashMap[target-num] {
                output.append(remainingTargetIndex)
                output.append(index)
                break
            }
            
            hashMap[num] = index
            index += 1
        }
        
        return output
    }
}