class Solution {
    func longestNiceSubstring(_ s: String) -> String {
        let slidingWindow = SlidingWindow(s)
        let inputStringCount = s.count
        var longestNiceSubstring = ""

        while slidingWindow.endIndex < inputStringCount {
            let currentWindowString = String(slidingWindow.value)
            let currentWindowStringCount = currentWindowString.count

            if currentWindowString.isNiceString && currentWindowStringCount > longestNiceSubstring.count  {
                longestNiceSubstring = currentWindowString
            }

            // We reached till the end for searching the longest nice string
            if slidingWindow.endIndex == (inputStringCount - 1) {
                // Move sliding window by 1 from start &
                // reset the endIndex to same as startIndex
                slidingWindow.startIndex += 1
                slidingWindow.endIndex = slidingWindow.startIndex - 1
            }

            slidingWindow.endIndex += 1
        }

        return longestNiceSubstring
    }
}

private extension String {
    var isNiceString: Bool {
        Double(Set(self.lowercased()).count) == (Double(Set(self).count) / 2.0)
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
