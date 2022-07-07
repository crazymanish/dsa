// https://leetcode.com/problems/check-if-every-row-and-column-contains-all-numbers

class Solution {
    func checkValid(_ matrix: [[Int]]) -> Bool {
        var isValid = true
        
        for elements in matrix {
            let n = elements.count
            var hashMap: [Int : Bool] = [:]
            var hashMapCounter = 0
            for element in elements {
                if hashMap[element] == nil {
                    hashMap[element] = true
                    hashMapCounter += 1
                }
            }
            
            if n != hashMapCounter {
                isValid = false
                break
            }
        }
        
        return isValid
    }
}