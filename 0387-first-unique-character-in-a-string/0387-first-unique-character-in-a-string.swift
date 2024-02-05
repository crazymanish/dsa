class Solution {
    func firstUniqChar(_ s: String) -> Int {
        var hashMap: [Character : Bool] = [:]
        
        for char in s {
            if hashMap[char] == nil {
                hashMap[char] = true
            } else {
                hashMap[char] = false
            }
        }
        
        var uniqueCharIndex = -1
        var currentIndex = 0
        for char in s {
            if hashMap[char]! == true { 
                uniqueCharIndex = currentIndex
                break 
            } 
            currentIndex += 1
        }
        
        return uniqueCharIndex
    }
}