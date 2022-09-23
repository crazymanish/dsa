class Solution {
    func concatenatedBinary(_ n: Int) -> Int {
        var binaryArray: [Bool] = []
        for number in 1...n { binaryArray += number.toBinary }
        
        var result = 0
        for binaryValue in binaryArray {
            result = result * 2 % 1000000007
            
            if binaryValue { result += 1 }
        }
        
        return result
    }
}

extension Int {
    var toBinary: [Bool] {
        var number = self
        var result: [Bool] = []
        
        while number != 0 {
            if number % 2 != 0 {
                result.insert(true, at: 0)
            } else {
                result.insert(false, at: 0)
            }
            number /= 2
        }
        
        return result
    }
}