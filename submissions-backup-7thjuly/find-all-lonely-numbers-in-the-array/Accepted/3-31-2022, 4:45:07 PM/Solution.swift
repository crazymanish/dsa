// https://leetcode.com/problems/find-all-lonely-numbers-in-the-array

class Solution {
    func findLonely(_ nums: [Int]) -> [Int] {
        var hashMap: [Int : Int] = [:]
        for num in nums {
            let hashMapValue = hashMap[num] ?? 0
            hashMap[num] = hashMapValue + 1
        }
        
        var output: [Int] = []
        for num in nums {
            if hashMap[num]! == 1 && hashMap[num-1] == nil && hashMap[num+1] == nil {
                output.append(num)
            }
        }
        
        return output
    }
}