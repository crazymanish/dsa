// https://leetcode.com/problems/long-pressed-name

class Solution {
    func isLongPressedName(_ name: String, _ typed: String) -> Bool {
        let nameHashMap = addIntoHashMap(name)
        let typedHashMap = addIntoHashMap(typed)
        
        for (key, value) in nameHashMap {
            let value2 = typedHashMap[key] ?? 0
            
            if value > value2 { return false }
        }
        
        return true
    }

    private func addIntoHashMap(_ word: String) -> [Character : Int] {
        var hashMap: [Character : Int] = [:]
        
        for char in word {
            if let hashMapValue = hashMap[char] {
                hashMap[char] = hashMapValue + 1
            } else {
                hashMap[char] = 1
            }
        }
        
        return hashMap
    }    
}