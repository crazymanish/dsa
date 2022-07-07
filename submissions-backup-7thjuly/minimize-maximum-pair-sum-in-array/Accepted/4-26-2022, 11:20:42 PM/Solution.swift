// https://leetcode.com/problems/minimize-maximum-pair-sum-in-array

class Solution {
    func minPairSum(_ nums: [Int]) -> Int {
        let numsSorted = nums.sorted()
        let numsCount = nums.count
        
        var leftPointer = 0
        var rightPointer = numsCount-1
        var maximumPairSum = Int.min
        
        while leftPointer < rightPointer {
            let pairSum = numsSorted[leftPointer] + numsSorted[rightPointer]
            maximumPairSum = max(maximumPairSum, pairSum)
            
            leftPointer += 1
            rightPointer -= 1
        }
        
        return maximumPairSum
    }
}