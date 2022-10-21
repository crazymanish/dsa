class Solution {
    typealias ValueIndex = [Int : Int]
    private var hashMap: ValueIndex = [:]
    private let slidingWindowSize = 2
    private var slidingWindow: SlidingWindow<[Int]>!

    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        slidingWindow = SlidingWindow(nums)
        let inputNumsCount = nums.count
        var isNearbyDuplicateFound = false

        while slidingWindow.endIndex < inputNumsCount {
            handleScenarioBeforeReachingTheWindowSize()
            isNearbyDuplicateFound = handleScenarioOnReachingTheWindowSize(k)

            if isNearbyDuplicateFound { break }

            // Slide window by one from end.
            slidingWindow.endIndex += 1
        }

        return isNearbyDuplicateFound
    }

    private func handleScenarioBeforeReachingTheWindowSize() {
        // Just keep adding values into hash with index
        if slidingWindow.value.count < slidingWindowSize {
            let lastValue = Array(slidingWindow.endIndexValue).first!

            hashMap[lastValue] = slidingWindow.endIndex
        }
    }

    private func handleScenarioOnReachingTheWindowSize(_ k: Int) -> Bool {
        if slidingWindow.value.count == slidingWindowSize {
            let lastValue = Array(slidingWindow.endIndexValue).first!

            if let cacheIndex = hashMap[lastValue], abs(cacheIndex - slidingWindow.endIndex) <= k {
                return true // Found the NearBy duplicate
            }
            hashMap[lastValue] = slidingWindow.endIndex

            // Slide window by one from start.
            slidingWindow.startIndex += 1
        }

        return false
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