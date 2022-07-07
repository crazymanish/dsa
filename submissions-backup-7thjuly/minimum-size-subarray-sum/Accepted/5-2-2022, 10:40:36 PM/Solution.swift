// https://leetcode.com/problems/minimum-size-subarray-sum

class Solution {
    func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
        let numsCount = nums.count
        let slidingWindow = SlidingWindow(nums)

        var output = Int.max

        while slidingWindow.endIndex < numsCount {
            slidingWindow.value += slidingWindow.endIndexValue

            while slidingWindow.value >= target {
                output = min(output, slidingWindow.size)
                slidingWindow.value -= slidingWindow.startIndexValue
                slidingWindow.startIndex += 1
            }

            slidingWindow.endIndex += 1
        }

        return output == Int.max ? 0 : output
    }
}

class SlidingWindow {
    var startIndex = 0
    var endIndex = 0

    var value = 0

    var startIndexValue: Int { array[startIndex] }
    var endIndexValue: Int { array[endIndex] }
    var size: Int { endIndex-startIndex+1 }

    private let array: [Int]

    init(_ array: [Int]) {
        self.array = array
    }
}
