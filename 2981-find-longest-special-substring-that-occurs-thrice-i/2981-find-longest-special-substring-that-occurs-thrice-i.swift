class Solution {
    func maximumLength(_ s: String) -> Int {
        var freq = [UInt8: [Int: Int]]()
        var currentChar: UInt8 = 0
        var length = 0
        var result = -1
        
        for char in s.utf8 {
            if char != currentChar { length = 0 }
            
            length += 1
            currentChar = char
            
            for i in max(1, length-2)..<length+1 {
                freq[currentChar, default: [:]][i, default: 0] += 1
                
                if freq[char]![i]! >= 3 { result = max(result, i)}
            }
        }
        
        return result
    }
}