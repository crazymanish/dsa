class Solution {
    func numberOfArithmeticSlices(_ nums: [Int]) -> Int {
        var result = 0
        var map = [[Int:Int]](repeating: [:], count: nums.count)
        
        for i in 0..<nums.endIndex {
            for j in 0..<i {
                let diff = nums[j] - nums[i]
                let count = map[j][diff, default: 0]

                result += count
                map[i][diff, default: 0] += count + 1
            }
        }
        
        return result
    }
}