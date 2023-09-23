class Solution {
    func longestStrChain(_ words: [String]) -> Int { 
        var sortedArray = words.sorted { $0.count < $1.count }
        var longestSequencelength = 1
        var map = [String: Int]()
        
        func getSmallerString(_ string: String, _ index: Int) -> String {
		    var smallerString = string
		    let i = smallerString.index(smallerString.startIndex, offsetBy: index)
		    
            smallerString.remove(at: i)
		    return smallerString
	    }
        
        for word in sortedArray {
            var currentLength = 1
            for index in 0..<word.count {
                var smallerString = getSmallerString(word, index)
                let previousLength = map[smallerString] ?? 0
                currentLength = max(currentLength,  previousLength + 1)  
            }
             map[word] = currentLength
             longestSequencelength = max(longestSequencelength, currentLength)
        }
        
        return longestSequencelength
    }
}