// https://leetcode.com/problems/maximum-number-of-vowels-in-a-substring-of-given-length

class Solution {
    private var slidingWindow: SlidingWindow<String>!
    private var slidingWindowSize = 0
    private var currentSlidingWindowVowelsLength = 0
    private var maximumVowelsLength = Int.min

    private var vowelsHashMap = ["a": true, "e": true, "i": true, "o": true, "u": true]

    private var slidingWindowFirstValue: String { String(slidingWindow.startIndexValue) }
    private var slidingWindowLastValue: String { String(slidingWindow.endIndexValue) }

    func maxVowels(_ s: String, _ k: Int) -> Int {
        slidingWindow = SlidingWindow(s)
        slidingWindowSize = k

        while slidingWindow.endIndex < s.count {
            if isVowel(slidingWindowLastValue) {
                handleWhenValueIsVowel()
            }

            if slidingWindow.size == slidingWindowSize {
                handleWhenWindowSizeIsMet()
            }

            // Slide window by one from end.
            slidingWindow.endIndex += 1
        }

        return maximumVowelsLength
    }

    private func isVowel(_ string: String) -> Bool { vowelsHashMap[string] != nil }

    private func handleWhenValueIsVowel() {
        currentSlidingWindowVowelsLength += 1
    }

    private func handleWhenWindowSizeIsMet() {
        maximumVowelsLength = max(maximumVowelsLength, currentSlidingWindowVowelsLength)

        if isVowel(slidingWindowFirstValue) {
            currentSlidingWindowVowelsLength -= 1
        }

        slidingWindow.startIndex += 1 // Slide window by one from start.
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
