class Solution {
    func romanToInt(_ s: String) -> Int {
        let hashMap : [Character : Int] = [
            "I" : 1,
            "V" : 5,
            "X" : 10,
            "L" : 50,
            "C" : 100,
            "D" : 500,
            "M" : 1000,
        ]
        
        var outputSum = 0
        
        var lastChar: Character? = nil
        for currentChar in s.reversed() {
            if let lastChar = lastChar {
                if currentChar == "I" && (lastChar == "V" || lastChar == "X" ) { outputSum -= 1 }
                else if currentChar == "X" && (lastChar == "L" || lastChar == "C" ) { outputSum -= 10 }
                else if currentChar == "C" && (lastChar == "D" || lastChar == "M" ) { outputSum -= 100 }
                else { outputSum += hashMap[currentChar]! }
            } else {
                outputSum += hashMap[currentChar]!
            }
            
            lastChar = currentChar
        }
        
        return outputSum
    }
}