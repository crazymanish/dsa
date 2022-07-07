// https://leetcode.com/problems/count-common-words-with-one-occurrence

class Solution {
    func countWords(_ words1: [String], _ words2: [String]) -> Int {
        var hashMap: [String : [Int : Int]] = [:]

        for word in words1 {
            if var hashMapValue = hashMap[word] {
                if let cacheValue = hashMapValue[1] {
                    hashMapValue[1] = cacheValue + 1
                    hashMap[word] = hashMapValue
                } else {
                    hashMapValue[1] = 1
                    hashMap[word] = hashMapValue
                }
            } else {
                hashMap[word] = [1 : 1]
            }
        }

        for word in words2 {
            if var hashMapValue = hashMap[word] {
                if let cacheValue = hashMapValue[2] {
                    hashMapValue[2] = cacheValue + 1
                    hashMap[word] = hashMapValue
                } else {
                    hashMapValue[2] = 1
                    hashMap[word] = hashMapValue
                }
            } else {
                hashMap[word] = [2 : 1]
            }
        }

        var output = 0
        for (_, value) in hashMap {
            if let value1 = value[1], 
            let value2 = value[2], 
            value1 == 1, value2 == 1 {
                output += 1
            }
        }

        return output
    }
}