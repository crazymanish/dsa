class Solution {
    func specialArray(_ nums: [Int]) -> Int {
        var left = 0
        var right = nums.count
        
        func countGreaterEqualTo(_ mid: Int) -> Int { nums.filter{ $0 >= mid }.count }
        
        while left < right {
            let mid = left + (right - left) / 2
            if countGreaterEqualTo(mid) == mid {
                return mid
            } else if countGreaterEqualTo(mid) < mid {
                right = mid
            } else {
                left = mid + 1
            }
        }
        
        return countGreaterEqualTo(left) == left ? left : -1
    }
}