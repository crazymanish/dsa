class Solution {
    private var hashMap: [String : Int] = [:]
    private var hashMapCounter = 0

    func countGoodSubstrings(_ s: String) -> Int {
        let slidingWindow = SlidingWindow(s)
        let windowSize = 3
        var goodStringsCount = 0

        while slidingWindow.endIndex < s.count {
            // Do cache endIndex value in HashMap
            let endValue = String(slidingWindow.endIndexValue)
            addIntoHashMap(endValue)

            let currentWindowValue = slidingWindow.value

            if currentWindowValue.count == windowSize {
                // Found the Good string!
                if hashMapCounter == windowSize { goodStringsCount += 1 }

                // Update startIndex cache value in HashMap
                let startValue = String(slidingWindow.startIndexValue)
                removeFromHashMap(startValue)

                // Move sliding window by 1
                slidingWindow.startIndex += 1
            }

            slidingWindow.endIndex += 1
        }

        return goodStringsCount
    }

    private func addIntoHashMap(_ value: String) {
        if let cacheValue = hashMap[value] {
            hashMap[value] = cacheValue + 1
        } else {
            hashMap[value] = 1
            hashMapCounter += 1
        }
    }

    private func removeFromHashMap(_ value: String) {
        if let cacheValue = hashMap[value] {
            hashMap[value] = cacheValue - 1
            if hashMap[value]! == 0 {
                hashMap.removeValue(forKey: value)
                hashMapCounter -= 1
            }
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
