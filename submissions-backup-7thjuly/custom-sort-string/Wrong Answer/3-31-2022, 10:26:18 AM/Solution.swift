// https://leetcode.com/problems/custom-sort-string

class Solution {
    func customSortString(_ order: String, _ s: String) -> String {
        var orderArray: [Character] = []
        for char in order { orderArray.append(char) }
        
        var frequencyHashMap: [Character: Int] = [:]
        for char in s {
            let hashMapValue = frequencyHashMap[char] ?? 0 
            frequencyHashMap[char] = hashMapValue + 1
        }
        
        var output = ""
        for char in orderArray {
            if let hashMapValue = frequencyHashMap[char], hashMapValue > 0 {
                output += String(char) 
                frequencyHashMap[char] = hashMapValue - 1
            }
        }
        
        for (key, var value) in frequencyHashMap {
            while value > 0 {
                output += String(key) 
                value -= 1
            }
        }
        
        return output
    }
}