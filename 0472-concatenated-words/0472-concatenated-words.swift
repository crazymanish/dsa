class Solution {
    func findAllConcatenatedWordsInADict(_ words: [String]) -> [String] {
        var wordSet = Set<String>(words)
        
        func isConcatenated(_ word: [Character]) -> Bool {
            var visitedSet = Set<Int>()
            var queue: [Int] = [0]
            var level = 0

            while !queue.isEmpty {
                var nextQueue = [Int]()
                level += 1
                for next in queue {
                    guard !visitedSet.contains(next) else { continue }
                    
                    visitedSet.insert(next)

                    var str = ""
                    for i in next..<word.count {
                        str.append(word[i])
                        if wordSet.contains(str) {
                            if i < word.count - 1 {
                                nextQueue.append(i + 1)
                            } else {
                                if level >= 2 {
                                    return true
                                }
                            }                        
                        }
                    }
                }
                queue = nextQueue
            }

            return false
        }
        
        var result = [String]()
        for word in words {
            if isConcatenated(Array(word)) {
                result.append(word)
            }
        }
        
        return result
    }
}