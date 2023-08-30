class Solution {
    func minimumReplacement(_ nums: [Int]) -> Int {
        var lastNum = nums.last! 
        var revNums = Array(nums.reversed())
        var operations = 0
        var i = 1

        while i <= revNums.count - 1 {
            let currentNum = revNums[i]

            if currentNum > lastNum {
                let stepsToSplit = (currentNum-1) / lastNum
                let leftOver =  currentNum / (stepsToSplit+1)

                revNums.insert(leftOver, at: i+1)
                operations += stepsToSplit
            }

            lastNum = revNums[i]
            i += 1
        }

        return operations
    }
}