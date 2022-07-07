// https://leetcode.com/problems/construct-k-palindrome-strings

class Solution {
    func canConstruct(_ s: String, _ k: Int) -> Bool {
        if s.count < k { return false }
        
        var hashMap: [Character : Int] = [:]
        for char in s {
            let hashMapValue = hashMap[char] ?? 0
            hashMap[char] = hashMapValue + 1
        }
        
        var oddFrequencyCount = 0
        
        for (key, value) in hashMap {
            if value % 2 != 0 { oddFrequencyCount += 1 }
            
            if oddFrequencyCount > k { return false }
        }
        
        return true
    }
}