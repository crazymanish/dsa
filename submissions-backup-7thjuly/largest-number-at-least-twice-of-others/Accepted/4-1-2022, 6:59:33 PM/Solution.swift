// https://leetcode.com/problems/largest-number-at-least-twice-of-others

class Solution {
    func dominantIndex(_ nums: [Int]) -> Int {
        let numsCount = nums.count
        
        if numsCount == 1 { return 0 }
        
        var hashMap: [Int: Int] = [:]
        for (index, num) in nums.enumerated() { hashMap[num] = index }
        
        var sortedNums = nums.sorted()
        let largestNum = sortedNums[numsCount-1]
        let secondLargestNum = sortedNums[numsCount-2]
        
        if largestNum >= secondLargestNum*2 {
            return hashMap[largestNum]!
        }
        
        return -1
    }
}