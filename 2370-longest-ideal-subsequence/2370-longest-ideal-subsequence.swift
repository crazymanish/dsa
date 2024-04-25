class Solution {
    func longestIdealString(_ s: String, _ k: Int) -> Int {
        var answer = 1
        
        var dpCache = Array(repeating: 0, count: 26)
        
        for iterator in s {
            var asciiValue = iterator.asciiValue! - 97
            var highestValue = 0
            
            for secondIterator in max(0, Int(asciiValue) - k)...min(25, Int(asciiValue) + k) {
                highestValue = max(highestValue, dpCache[secondIterator]) 
            }
            
            dpCache[Int(asciiValue)] = highestValue + 1
            answer = max(answer,highestValue + 1)
        }
        
        return answer
    }
}