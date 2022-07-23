class Solution {
    func numDifferentIntegers(_ word: String) -> Int {
        var resultSet : Set<String> = []
        
        let digits: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        var currentDigit = ""
        
        for char in word {
            if digits.contains(char) {
                currentDigit += String(char)
            } else if currentDigit.count > 0 { 
                resultSet.insert(currentDigit.trimLeadingZeros)
                currentDigit = ""
            }
        }
        
        if currentDigit.count > 0 { 
            resultSet.insert(currentDigit.trimLeadingZeros)
        }
        
        return resultSet.count
    }
}

private extension String {
    var trimLeadingZeros: String {
        var currentString = self
        
        while currentString.first == "0" {
            currentString.removeFirst()
        }
        
        return currentString
    }
}