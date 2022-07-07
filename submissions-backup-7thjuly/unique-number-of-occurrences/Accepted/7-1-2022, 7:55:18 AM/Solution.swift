// https://leetcode.com/problems/unique-number-of-occurrences

class Solution {
    func uniqueOccurrences(_ arr: [Int]) -> Bool {
        var hashMap: [Int : Int] = [:]
        
        for number in arr {
            if let hashMapOccurrence = hashMap[number] {
                hashMap[number] = hashMapOccurrence + 1
            } else {
                hashMap[number] = 1
            }
        }
        
        var isAllUniqueOccurrences = true

        var uniqueHashMap: [Int : Bool] = [:]
        for (_, value) in hashMap {
            if uniqueHashMap[value] == nil {
                uniqueHashMap[value] = true
            } else {
                isAllUniqueOccurrences = false
                break
            }
        }
        
        
        return isAllUniqueOccurrences
    }
}