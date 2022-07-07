// https://leetcode.com/problems/number-of-substrings-containing-all-three-characters

class Solution {
    private var slidingWindow: SlidingWindow<String>!
    private var slidingWindowFirstValue: String { String(slidingWindow.startIndexValue) }
    private var slidingWindowLastValue: String { String(slidingWindow.endIndexValue) }

    private var hashMap: [String : Int] = [:]
    private var foundSubString: Bool {
        var counter = 0

        if hashMap["a"] != nil { counter += 1 }
        if hashMap["b"] != nil { counter += 1 }
        if hashMap["c"] != nil { counter += 1 }

        return counter == 3
    }

    func numberOfSubstrings(_ s: String) -> Int {
        slidingWindow = SlidingWindow(s)
        let inputStringCount = s.count
        var numberOfSubstrings = 0
        var slidingWindowSize = 3

        while slidingWindowSize <= inputStringCount {
            hashMap = [:]
            slidingWindow.startIndex = 0
            slidingWindow.endIndex = 0

            numberOfSubstrings += findSubstrings(slidingWindowSize, inputStringCount)
            slidingWindowSize += 1
        }

        return numberOfSubstrings
    }

    func findSubstrings(_ slidingWindowSize: Int, _ inputStringCount: Int) -> Int {
        var numberOfSubstrings = 0

        while slidingWindow.endIndex < inputStringCount {
            addIntoHashMap(slidingWindowLastValue)

            if slidingWindow.value.count == slidingWindowSize {
                if foundSubString { numberOfSubstrings += 1 }

                // Update startIndex cache value in HashMap
                removeFromHashMap(slidingWindowFirstValue)

                // Move sliding window by 1
                slidingWindow.startIndex += 1
            }

            slidingWindow.endIndex += 1
        }

        return numberOfSubstrings
    }

    private func addIntoHashMap(_ value: String) {
        if let cacheValue = hashMap[value] {
            hashMap[value] = cacheValue + 1
        } else {
            hashMap[value] = 1
        }
    }

    private func removeFromHashMap(_ value: String) {
        if let cacheValue = hashMap[value] {
            hashMap[value] = cacheValue - 1

            if hashMap[value]! == 0 { hashMap.removeValue(forKey: value) }
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