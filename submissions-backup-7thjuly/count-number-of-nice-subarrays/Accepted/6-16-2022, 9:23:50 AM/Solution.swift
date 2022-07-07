// https://leetcode.com/problems/count-number-of-nice-subarrays

class Solution {
    private var slidingWindow: SlidingWindow<[Int]>!
    private var currentSlidingWindowSubarrays = 0
    private var numberOfSubarrays = 0
    private var targetOddNumbers = 0

    private var slidingWindowFirstValue: Int { Array(slidingWindow.startIndexValue).first! }
    private var slidingWindowLastValue: Int { Array(slidingWindow.endIndexValue).first! }

    func numberOfSubarrays(_ nums: [Int], _ k: Int) -> Int {
        slidingWindow = SlidingWindow(nums)
        targetOddNumbers = k

        while slidingWindow.endIndex < nums.count {
            if slidingWindowLastValue % 2 != 0 { handleWhenValueIsOdd() }

            handleWhenTargetOddNumbersConditionMet()

            numberOfSubarrays += currentSlidingWindowSubarrays

            // Slide window by one from end.
            slidingWindow.endIndex += 1
        }

        return numberOfSubarrays
    }

    private func handleWhenValueIsOdd() {
        targetOddNumbers -= 1
        currentSlidingWindowSubarrays = 0
    }

    private func handleWhenTargetOddNumbersConditionMet() {
        while targetOddNumbers == 0 {
            if slidingWindowFirstValue % 2 != 0 { targetOddNumbers += 1 }

            currentSlidingWindowSubarrays += 1
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
