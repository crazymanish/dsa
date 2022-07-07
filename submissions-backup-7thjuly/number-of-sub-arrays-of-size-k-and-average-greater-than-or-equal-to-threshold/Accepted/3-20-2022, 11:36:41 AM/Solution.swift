// https://leetcode.com/problems/number-of-sub-arrays-of-size-k-and-average-greater-than-or-equal-to-threshold

class Solution {
    typealias ValueIndex = [Int : Int]
    private var hashMap: ValueIndex = [:]
    private var slidingWindowSize: Int!
    private var slidingWindow: SlidingWindow<[Int]>!
    private var currentSlidingWindowSum: Double = 0
    private var numOfSubarrays: Int = 0

    func numOfSubarrays(_ arr: [Int], _ k: Int, _ threshold: Int) -> Int {
        slidingWindow = SlidingWindow(arr)
        slidingWindowSize = k
        let inputNumsCount = arr.count

        while slidingWindow.endIndex < inputNumsCount {
            handleScenarioBeforeReachingTheWindowSize()

            handleScenarioOnReachingTheWindowSize(threshold)

            // Slide window by one from end.
            slidingWindow.endIndex += 1
        }

        return numOfSubarrays
    }

    private func handleScenarioBeforeReachingTheWindowSize() {
        // Just keep adding values into sum
        if slidingWindow.value.count <= slidingWindowSize {
            let lastValue = Array(slidingWindow.endIndexValue).first!

            currentSlidingWindowSum += Double(lastValue)
        }
    }

    private func handleScenarioOnReachingTheWindowSize(_ threshold: Int) {
        if slidingWindow.value.count == slidingWindowSize {
            let currentWindowAvg = currentSlidingWindowSum / Double(slidingWindowSize)
            if currentWindowAvg >= Double(threshold) {
                numOfSubarrays += 1 // YaY: Found valid sub-array
            }

            // Remove start window element from current-sum, before sliding next window
            let startValue = Array(slidingWindow.startIndexValue).first!
            currentSlidingWindowSum -= Double(startValue)

            // Slide window by one from start.
            slidingWindow.startIndex += 1
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
