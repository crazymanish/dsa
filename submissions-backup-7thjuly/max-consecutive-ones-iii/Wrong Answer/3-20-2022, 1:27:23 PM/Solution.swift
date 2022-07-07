// https://leetcode.com/problems/max-consecutive-ones-iii

class Solution {
    private var slidingWindow: SlidingWindow<[Int]>!
    private var flipPossibleCount: Int!
    private var currentWindowConsecutiveOnes = 0
    private var maximumConsecutiveOnes = Int.min

    private var slidingWindowFirstValue: Int { Array(slidingWindow.startIndexValue).first! }
    private var slidingWindowLastValue: Int { Array(slidingWindow.endIndexValue).first! }

    func longestOnes(_ nums: [Int], _ k: Int) -> Int {
        slidingWindow = SlidingWindow(nums)
        flipPossibleCount = k
        let inputNumsCount = nums.count

        while slidingWindow.endIndex < inputNumsCount {
            if slidingWindowLastValue == 1 {
                handleWhenValueIsOne()
            } else {
                handleWhenValueIsZero()
            }
        }

        return maximumConsecutiveOnes
    }

    // if sliding value is coming as 1, don't do anything just increment the ConsecutiveOnes
    private func handleWhenValueIsOne() {
        currentWindowConsecutiveOnes += 1
        slidingWindow.endIndex += 1 // Slide window by one from end.
    }

    private func handleWhenValueIsZero() {
        // lets see if have chance to make 0 into 1 first using K(flipPossibleCount) value
        if flipPossibleCount > 0 {
            flipPossibleCount -= 1
            currentWindowConsecutiveOnes += 1
            slidingWindow.endIndex += 1 // Slide window by one from end.
        } else if flipPossibleCount == 0 {
            // We found maximum ConsecutiveOnes in this sliding-window
            maximumConsecutiveOnes = max(maximumConsecutiveOnes, currentWindowConsecutiveOnes)

            // Adjust currentWindowConsecutiveOnes, before sliding next window
            currentWindowConsecutiveOnes -= 1

            if slidingWindowFirstValue == 0 {
                flipPossibleCount += 1
            }

            slidingWindow.startIndex += 1 // Slide window by one from start.
        }
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