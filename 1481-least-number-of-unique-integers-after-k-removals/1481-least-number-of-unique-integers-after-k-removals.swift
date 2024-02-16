class Solution {
    func findLeastNumOfUniqueInts(_ arr: [Int], _ k: Int) -> Int {
        var hashMap: [Int : Int] = [:]
        for num in arr {
            let hashMapValue = hashMap[num] ?? 0
            hashMap[num] = hashMapValue + 1
        }
        
        let sortedHashMap = hashMap.sorted { $0.1 < $1.1 }
        
        var mutableK = k
        for (key, value) in sortedHashMap {
            if mutableK < 1 { break }
            
            let hashMapValue = hashMap[key]!
            
            if hashMapValue <= mutableK {
                hashMap[key] = 0
            } else {
                hashMap[key] = hashMapValue - mutableK
            }
            
            mutableK -= hashMapValue
        }
        
        var output = 0
        for (key, value) in hashMap {
            if value > 0 { output += 1 }
        }
        
        return output
    }
}