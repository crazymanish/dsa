// https://leetcode.com/problems/count-vowel-substrings-of-a-string

class Solution {
    let vowelsHashMap: [Character:Bool] = ["a": true, "e": true, "i": true, "o": true, "u": true]
    
    func countVowelSubstrings(_ word: String) -> Int {
        var slidingWindow = SlidingWindow(word)
        var slidingWindowLastValue: Character { slidingWindow.endIndexValue.first! }
        var frequencyHashMap: [Character:Int] = [:]
        var vowelsCounter = 0
        var output = 0
        
        while slidingWindow.endIndex < word.count {
            let lastValue = slidingWindowLastValue
            if isVowel(lastValue) {
                handleVowel(lastValue, &slidingWindow, &frequencyHashMap, &vowelsCounter, &output)
            } else {
                handleNotVowel(&slidingWindow, &frequencyHashMap, &vowelsCounter)
            }
        }
        
        return output
    }
    
    func isVowel(_ char: Character) -> Bool { vowelsHashMap[char] != nil }
    
    private func handleVowel(
        _ char: Character, 
        _ slidingWindow: inout SlidingWindow<String>, 
        _ frequencyHashMap: inout [Character:Int], 
        _ vowelsCounter: inout Int,
        _ output: inout Int) {
        if let hashMapValue = frequencyHashMap[char] {
            frequencyHashMap[char] = hashMapValue + 1
        } else {
            frequencyHashMap[char] = 1
            vowelsCounter += 1
        }
        
        if vowelsCounter == 5 { 
            output += 1 
        }
        
        slidingWindow.endIndex += 1 // Slide window by one from end.
    }
    
    private func handleNotVowel(
        _ slidingWindow: inout SlidingWindow<String>, 
        _ frequencyHashMap: inout [Character:Int], 
        _ vowelsCounter: inout Int) {
        frequencyHashMap = [:]
        vowelsCounter = 0
        
        slidingWindow.startIndex += 1 // Slide window by one from start.
        slidingWindow.endIndex = slidingWindow.startIndex // Reset Slide window from end.
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