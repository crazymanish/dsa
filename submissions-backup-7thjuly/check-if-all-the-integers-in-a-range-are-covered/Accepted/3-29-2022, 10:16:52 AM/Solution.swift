// https://leetcode.com/problems/check-if-all-the-integers-in-a-range-are-covered

class Solution {
    func isCovered(_ ranges: [[Int]], _ left: Int, _ right: Int) -> Bool {
        var hashMap: [Int : Bool] = [:]
        
        for rangeValue in left...right {
            hashMap[rangeValue] = false
        }
        
        for range in ranges {
            for rangeValue in range[0]...range[1] {
                hashMap[rangeValue] = true
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