class Solution {
    func frequencySort(_ s: String) -> String {
        typealias Frequency = Int
        var hashMap: [Character : Frequency] = [:]
        
        for char in s {
            let hashMapValue = hashMap[char] ?? 0
            hashMap[char] = hashMapValue + 1
        }
        
        var outputString = ""
        var hashMapSize = Array(hashMap.keys).count
        
        while (hashMapSize > 0)  {
            var maximumKey: Character = "-"
            var maximumValue = Int.min
            
            for (key, value) in hashMap {
                if value > maximumValue {
                    maximumKey = key
                    maximumValue = value
                }
            }
            
            while maximumValue != 0 {
                outputString += String(maximumKey)
                maximumValue -= 1
            }
            
            hashMap[maximumKey] = 0
            hashMapSize -= 1
        }
        
        return outputString
    }
}