// https://leetcode.com/problems/check-if-one-string-swap-can-make-strings-equal

class Solution {
    func areAlmostEqual(_ s1: String, _ s2: String) -> Bool {
        let hashMapS1 = hashMap(s1)
        let hashMapS2 = hashMap(s2)
        
        var areAlmostEqual = true
        
        var hashMapDiff: [Character : Character] = [:]
        for (key, value1) in hashMapS1 {
            let value2 = hashMapS2[key]!
            
            if value1 != value2 {
                if hashMapDiff[value1] != nil {
                    areAlmostEqual = false
                    break
                } else {
                    hashMapDiff[value1] = value2   
                }
            }
        }
        
        if areAlmostEqual {
            let diffKeys = Array(hashMapDiff.keys)
        
            if diffKeys.count == 0 { areAlmostEqual = true }
            else if diffKeys.count == 2 {
                let firstKey = diffKeys[0]
                let secondKey = diffKeys[1]
            
                let firstValue = hashMapDiff[firstKey]
                let secondValue = hashMapDiff[secondKey]
            
                if firstKey == secondValue && firstValue == secondKey { areAlmostEqual = true }
            } else {
                areAlmostEqual = false
            }
        }
        
        return areAlmostEqual
    }

    private func hashMap(_ string: String) -> [Int : Character] {
        var hashMap: [Int : Character] = [:]

        for index in 0..<string.count {
            hashMap[index] = string[index]
        }

        return hashMap
    }
}

private extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}