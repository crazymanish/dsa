// https://leetcode.com/problems/maximum-average-subarray-i

class Solution {
    func findMaxAverage(_ nums: [Int], _ k: Int) -> Double {
        if k < 1 { return 0 }

        let slidingWindow = SlidingWindow(nums)
        let inputNumsCount = nums.count
        let windowSize = k
        var currentSlidingWindowSum: Double = 0
        var maxAverage: Double = Double(Int.min)

        while slidingWindow.endIndex < inputNumsCount {
            let lastValue = Array(slidingWindow.endIndexValue).first!
            currentSlidingWindowSum += Double(lastValue)

            if slidingWindow.value.count == windowSize {
                let currentWindowAverage = currentSlidingWindowSum / Double(windowSize)
                maxAverage = max(maxAverage, currentWindowAverage)

                // Before sliding the window, adjust the sliding-sum
                let startValue = Array(slidingWindow.startIndexValue).first!
                currentSlidingWindowSum -= Double(startValue)
                slidingWindow.startIndex += 1
            }

            slidingWindow.endIndex += 1
        }

        return maxAverage
    }
}

class SlidingWindow<T: Collection> {
    let collection: T

    var startIndex: Int
    var endIndex: Int

    var value: T.SubSequence { value(at: startIndex, endIndex: endIndex) }
    var startIndexValue: T.SubSequence { value(at: startIndex) }
    var endIndexValue: T.SubSequence { value(at: endIndex) }

    init(_ collection: T, _ startIndex: Int = 0, _ endIndex: Int = 0) {
        self.collection = collection
        self.startIndex = startIndex
        self.endIndex = endIndex
    }

    private func value(at index: Int) -> T.SubSequence { value(at: index, endIndex: index) }

    private func value(at startIndex: Int, endIndex: Int) -> T.SubSequence {
        let start = collection.index(collection.startIndex, offsetBy: startIndex)
        let end = collection.index(collection.startIndex, offsetBy: endIndex)

        return collection[start...end]
    }
}
