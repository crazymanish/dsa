// https://leetcode.com/problems/minimum-difference-between-highest-and-lowest-of-k-scores

class Solution {
    private var minimumDifference = Int.max

    func minimumDifference(_ nums: [Int], _ k: Int) -> Int {
        if k < 1 { return 0 }

        let slidingWindow = SlidingWindow(nums.sorted())
        let inputNumsCount = nums.count
        let windowSize = k

        while slidingWindow.endIndex < inputNumsCount {
            if slidingWindow.value.count == windowSize {
                let minValue = Array(slidingWindow.startIndexValue).first!
                let maxValue = Array(slidingWindow.endIndexValue).first!

                let currentWindowDifference = maxValue - minValue
                minimumDifference = min(minimumDifference, currentWindowDifference)

                slidingWindow.startIndex += 1
            }

            slidingWindow.endIndex += 1
        }

        return minimumDifference
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
