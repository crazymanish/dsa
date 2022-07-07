// https://leetcode.com/problems/longest-subarray-of-1s-after-deleting-one-element

class Solution {
    private var slidingWindow: SlidingWindow<[Int]>!
    private var canIgnoreZero = true
    private var currentWindowConsecutiveOnes = 0
    private var maximumConsecutiveOnes = Int.min

    private var slidingWindowFirstValue: Int { Array(slidingWindow.startIndexValue).first! }
    private var slidingWindowLastValue: Int { Array(slidingWindow.endIndexValue).first! }

    func longestSubarray(_ nums: [Int]) -> Int {
        slidingWindow = SlidingWindow(nums)
        let inputNumsCount = nums.count
        var zeroAdjustment = 1

        while slidingWindow.endIndex < inputNumsCount {
            if slidingWindowLastValue == 1 {
                handleWhenValueIsOne()
            } else {
                zeroAdjustment = 0
                handleWhenValueIsZero()
            }
        }

        maximumConsecutiveOnes = (max(maximumConsecutiveOnes, currentWindowConsecutiveOnes)) - zeroAdjustment

        return maximumConsecutiveOnes
    }

    private func handleWhenValueIsOne() {
        currentWindowConsecutiveOnes += 1
        slidingWindow.endIndex += 1 // Slide window by one from end.
    }

    private func handleWhenValueIsZero() {
        if canIgnoreZero {
            canIgnoreZero = false
            slidingWindow.endIndex += 1 // Slide window by one from end.
        } else {
            // We found maximum ConsecutiveOnes in this sliding-window
            maximumConsecutiveOnes = max(maximumConsecutiveOnes, currentWindowConsecutiveOnes)

            while slidingWindowFirstValue != 0 {
                // Adjust currentWindowConsecutiveOnes, before sliding next window
                currentWindowConsecutiveOnes -= 1

                slidingWindow.startIndex += 1 // Slide window by one from start.
            }

            canIgnoreZero = true
            slidingWindow.startIndex += 1 // Slide window by one from start.
        }
    }
}

class SlidingWindow<T: Collection> {
    let collection: T

    var startIndex: Int
    var endIndex: Int

    var value: T.SubSequence { value(at: startIndex, endIndex: endIndex) }
    var size: Int { endIndex - startIndex + 1 }
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
