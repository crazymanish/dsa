// https://leetcode.com/problems/valid-palindrome-ii

class Solution {
    func validPalindrome(_ s: String) -> Bool {
        var hashMap: [Character : Int] = [:]
        
        for char in s {
            let hashMapValue = hashMap[char] ?? 0
            hashMap[char] = hashMapValue + 1
        }
        
        var oddValueCount = 0

        for (_, value) in hashMap {
            if value % 2 != 0 { oddValueCount += 1 }
        }
        
        return oddValueCount < 3
    }
}