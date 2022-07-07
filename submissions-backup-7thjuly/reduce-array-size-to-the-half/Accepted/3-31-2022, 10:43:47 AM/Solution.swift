// https://leetcode.com/problems/reduce-array-size-to-the-half

class Solution {
    func minSetSize(_ arr: [Int]) -> Int {
        let arrayCount = arr.count
        var hashMap: [Int : Int] = [:]
        
        for element in arr {
            let hashMapValue = hashMap[element] ?? 0
            hashMap[element] = hashMapValue + 1
        }
        
        let sortedHashMap = hashMap.sorted { $0.value > $1.value}
        var count = 0
        var sum = 0
        
        for ( _ , value) in sortedHashMap {
            if (arrayCount/2) > sum {
                count += 1
            } else {
                break
            }
            
            sum += value
        }
        
        return count
    }
}
