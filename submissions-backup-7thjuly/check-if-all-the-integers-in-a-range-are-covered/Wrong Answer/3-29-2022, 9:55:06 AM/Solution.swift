// https://leetcode.com/problems/check-if-all-the-integers-in-a-range-are-covered

class Solution {
    func isCovered(_ ranges: [[Int]], _ left: Int, _ right: Int) -> Bool {
        var isLeftCovered = false
        var isRightCovered = false
        
        for range in ranges {
            if isLeftCovered == false && range[0] <= left && left <= range[1] {
                isLeftCovered = true
            }
            
            if isRightCovered == false && range[0] <= right && right <= range[1] {
                isRightCovered = true
            }
            
            if isLeftCovered && isRightCovered { break }
        }
        
        return isLeftCovered && isRightCovered
    }
}