// https://leetcode.com/problems/find-all-duplicates-in-an-array

class Solution {
    func findDuplicates(_ nums: [Int]) -> [Int] {
        var hashMap: [Int : Bool] = [:]
        var output: [Int] = []
        
        for num in nums {
            if hashMap[num] == nil {
                hashMap[num] = true
            } else {
                output.append(num)
            }
        }
        
        return output
    }
}