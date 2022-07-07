// https://leetcode.com/problems/finding-3-digit-even-numbers

class Solution {
    func findEvenNumbers(_ digits: [Int]) -> [Int] {
        var digitsHashMap: [Int: Int] = [:]
        for digit in digits {
            let hashMapValue = digitsHashMap[digit] ?? 0
            digitsHashMap[digit] = hashMapValue + 1
        }
        
        var outputArray: [Int] = []
        
        for digit in 100...999 {
            if digit % 2 == 0 {
                let evenDigitHashMap = evenDigitHashMap(digit)
                var isFoundValidDigit = true
                for (key, value) in evenDigitHashMap {
                    if let value2 = digitsHashMap[key], value2 >= value {
                        isFoundValidDigit = true
                    } else {
                        isFoundValidDigit = false
                        break
                    }
                }
                
                if isFoundValidDigit {
                    outputArray.append(digit)
                }
            }
        }
        
        return outputArray.sorted()
    }
    
    func evenDigitHashMap(_ digit: Int) -> [Int: Int] {
        var hashMap: [Int: Int] = [:]
        var mutatedDigit = digit
        
        let thirdNumber = mutatedDigit % 10
        mutatedDigit = mutatedDigit / 10
        
        let secondNumber = mutatedDigit % 10
        mutatedDigit = mutatedDigit / 10
        
        let firstNumber = mutatedDigit
        
        var hashMapValue = hashMap[firstNumber] ?? 0
        hashMap[firstNumber] = hashMapValue + 1
            
        hashMapValue = hashMap[secondNumber] ?? 0
        hashMap[secondNumber] = hashMapValue + 1
            
        hashMapValue = hashMap[thirdNumber] ?? 0
        hashMap[thirdNumber] = hashMapValue + 1
            
        return hashMap
    }
}