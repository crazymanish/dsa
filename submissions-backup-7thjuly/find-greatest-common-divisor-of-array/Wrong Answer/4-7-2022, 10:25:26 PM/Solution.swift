// https://leetcode.com/problems/find-greatest-common-divisor-of-array

class Solution {
    func findGCD(_ nums: [Int]) -> Int {
        let numsCount = nums.count
        let sortedNums = nums.sorted()
        
        let minNum = nums[0]
        let maxNum = nums[numsCount-1]
        
        var gcd = 1
        for currentGCD in 1...minNum {
            if minNum % currentGCD == 0 && maxNum % currentGCD == 0 {
                gcd = currentGCD
            }
        }
        
        return gcd
    }
}