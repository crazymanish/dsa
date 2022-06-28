class Solution {
    func areOccurrencesEqual(_ s: String) -> Bool {
        typealias CharFrequency = [Character : Int]
        var hashMap: CharFrequency = [:]
        
        for char in s {
            if let currentFrequency = hashMap[char] {
                hashMap[char] = currentFrequency + 1
            } else {
                hashMap[char] = 1
            }
        }
        
        var isEqualFrequency = true
        let firstCharFrequency = hashMap[s.first!]
        for (_, value) in hashMap {
            if value != firstCharFrequency {
                isEqualFrequency = false
                break
            }
        }
        
        return isEqualFrequency
    }
}