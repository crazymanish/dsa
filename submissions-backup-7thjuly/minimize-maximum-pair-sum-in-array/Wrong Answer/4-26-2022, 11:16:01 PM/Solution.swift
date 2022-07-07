// https://leetcode.com/problems/minimize-maximum-pair-sum-in-array

class Solution {
    func minPairSum(_ nums: [Int]) -> Int {
        let numsSorted = nums.sorted()
        let numsCount = nums.count
        
        var outputNums: [Int] = []
        var index = 0
        while index < numsCount {
            let value = numsSorted[index]
            
            if index+1 < numsCount && numsSorted[index+1] == value { // Ignore duplicate
                index += 1
            } else {
                outputNums.append(value)
            }
            
            index += 1 
        }
        
        var outputNumsCount = outputNums.count
        var leftPointer = 0
        var rightPointer = outputNumsCount-1
        
        var minimumPairSum = Int.max
        while leftPointer < rightPointer {
            let pairSum = outputNums[leftPointer] + outputNums[rightPointer]
            minimumPairSum = min(minimumPairSum, pairSum)
            
            leftPointer += 1
            rightPointer -= 1
        }
        
        return minimumPairSum
    }
}