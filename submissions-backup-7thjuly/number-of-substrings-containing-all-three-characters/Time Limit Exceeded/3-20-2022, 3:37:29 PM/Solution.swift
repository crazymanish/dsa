// https://leetcode.com/problems/number-of-substrings-containing-all-three-characters

class Solution {
    func numberOfSubstrings(_ s: String) -> Int {
        let slidingWindow = SlidingWindow(s)
        var slidingWindowFirstValue: String { String(slidingWindow.startIndexValue) }
        var slidingWindowLastValue: String { String(slidingWindow.endIndexValue) }

        var hashMap: [String: Int] = [:]
        var isFoundSubString: Bool { hashMap["a"]! > 0 && hashMap["b"]! > 0 && hashMap["c"]! > 0 }

        let inputStringCount = s.count
        var numberOfSubstrings = 0
        var slidingWindowSize = 3

        while slidingWindowSize <= inputStringCount {
            hashMap = ["a": 0, "b": 0, "c": 0]
            slidingWindow.startIndex = 0
            slidingWindow.endIndex = 0

            while slidingWindow.endIndex < inputStringCount {
                let lastValue = slidingWindowLastValue
                hashMap[lastValue] = hashMap[lastValue]! + 1

                if slidingWindow.size == slidingWindowSize {
                    if isFoundSubString { numberOfSubstrings += 1 }

                    // Update startIndex cache value in HashMap
                    let firstValue = slidingWindowFirstValue
                    hashMap[firstValue] = hashMap[firstValue]! - 1

                    // Move sliding window by 1
                    slidingWindow.startIndex += 1
                }

                slidingWindow.endIndex += 1
            }

            slidingWindowSize += 1
        }

        return numberOfSubstrings
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