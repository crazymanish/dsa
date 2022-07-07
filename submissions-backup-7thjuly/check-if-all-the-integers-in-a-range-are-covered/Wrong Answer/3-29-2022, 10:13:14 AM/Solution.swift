// https://leetcode.com/problems/check-if-all-the-integers-in-a-range-are-covered

class Solution {
    func isCovered(_ ranges: [[Int]], _ left: Int, _ right: Int) -> Bool {
        var hashMap: [Int : Bool] = [:]
        hashMap[left] = false
        hashMap[right] = false
        
        for range in ranges {
            if let firstRange = hashMap[range[0]], firstRange == false {
                hashMap[range[0]] = true
            }
            
            if let secondRange = hashMap[range[1]], secondRange == false {
                hashMap[range[1]] = true
            }
        }
        
        var isCovered = true
        for (_, value) in hashMap {
            if value == false {
                isCovered = false
                break
            }
        }
        
        return isCovered
    }
}