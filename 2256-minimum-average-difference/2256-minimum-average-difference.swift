class Solution {
    func minimumAverageDifference(_ nums: [Int]) -> Int {
        // the idea here is that
        // we want to use running average to find the minimum
        var leftSum = 0
        var leftCounter = 0
        
        var rightSum = nums.reduce(0, { $0 + $1 })
        var rightCounter = nums.count
        
        var minIndex = -1
        var minAverageDifference = Int.max
        
        for index in 0..<nums.count {
            leftSum += nums[index]
            leftCounter += 1
            
            rightSum -= nums[index]
            rightCounter -= 1
            
            let averageDifference = abs(leftSum / leftCounter - rightSum / max(rightCounter, 1))
            if averageDifference < minAverageDifference {
                minAverageDifference = averageDifference
                minIndex = index
            }
        }
        
        return minIndex
    }
}