// https://leetcode.com/problems/maximum-number-of-vowels-in-a-substring-of-given-length

class Solution {
    private var slidingWindow: SlidingWindow!
    private var slidingWindowSize = 0
    private var currentSlidingWindowVowelsLength = 0
    private var maximumVowelsLength = Int.min

    private var vowelsHashMap = ["a": true, "e": true, "i": true, "o": true, "u": true]

    func maxVowels(_ s: String, _ k: Int) -> Int {
        slidingWindow = SlidingWindow(s)
        slidingWindowSize = k

        while slidingWindow.endIndex < s.count {
            if isVowel(slidingWindow.endIndexValue) {
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

        if isVowel(slidingWindow.startIndexValue) {
            currentSlidingWindowVowelsLength -= 1
        }

        slidingWindow.startIndex += 1 // Slide window by one from start.
    }
}

class SlidingWindow {
    let collection: [String]
    var startIndex: Int
    var endIndex: Int
    
    var size: Int { endIndex - startIndex + 1 }
    var startIndexValue: String { collection[startIndex] }
    var endIndexValue: String { collection[endIndex] }

    init(_ string: String, _ startIndex: Int = 0, _ endIndex: Int = 0) {
        var collection: [String] = []
        for char in string { collection.append(String(char)) }

        self.collection = collection
        self.startIndex = startIndex
        self.endIndex = endIndex
    }
}
