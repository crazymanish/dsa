class Solution {
    func firstMissingPositive(_ nums: [Int]) -> Int {
        let n = nums.count
        var eNums = nums
        
        for i in 0..<n {
            if eNums[i] <= 0 {
                eNums[i] = n + 1
            }
        }
        
        for i in 0..<n {
            let index = abs(eNums[i]) - 1
            if index >= 0 && index < n && eNums[index] > 0 {
                eNums[index] *= -1
            }
        }
        
        for i in 0..<n {
            if eNums[i] > 0 {
                return i + 1
            }
        }
        
        return n + 1
    }
}