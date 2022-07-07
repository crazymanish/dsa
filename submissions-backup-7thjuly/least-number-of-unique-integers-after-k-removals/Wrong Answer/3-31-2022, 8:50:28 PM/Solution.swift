// https://leetcode.com/problems/least-number-of-unique-integers-after-k-removals

class Solution {
    func findLeastNumOfUniqueInts(_ arr: [Int], _ k: Int) -> Int {
        var hashMap: [Int : Int] = [:]
        for num in arr {
            let hashMapValue = hashMap[num] ?? 0
            hashMap[num] = hashMapValue + 1
        }
        
        let sortedHashMap = hashMap.sorted { $0.1 < $1.1 }
        
        var mutableK = 0
        for (key, value) in sortedHashMap {
            if mutableK == k { break }
            
            hashMap[key] = hashMap[key]! - 1 
            mutableK += 1
        }
        
        var output = 0
        for (key, value) in hashMap {
            if value > 0 { output += 1 }
        }
        
        return output
    }
}