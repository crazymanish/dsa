class Solution {
    func longestPalindrome(_ s: String) -> Int {
        var hashMap: [Character : Int] = [:]

        for char in s {
            let hashMapValue = hashMap[char] ?? 0
            hashMap[char] = hashMapValue + 1
        }

        var output = 0
        var isOddValueFound = false

        for (_, value) in hashMap {
            if isOddValueFound == false && value % 2 != 0 { isOddValueFound = true }
            
            output += (value / 2) * 2
        }
        
        if isOddValueFound { output += 1 }

        return output
    }
}