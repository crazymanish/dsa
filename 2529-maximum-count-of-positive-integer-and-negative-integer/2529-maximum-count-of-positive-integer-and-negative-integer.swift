class Solution {
    func maximumCount(_ nums: [Int]) -> Int {
        var positiveCount = 0
        var negativeCount = 0

        for num in nums {
            if num > 0 {
                positiveCount += 1
            } else if num < 0 {
                negativeCount += 1
            }
        }

        return max(positiveCount, negativeCount)
    }
}