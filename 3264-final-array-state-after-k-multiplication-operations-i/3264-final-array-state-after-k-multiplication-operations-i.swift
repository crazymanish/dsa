class Solution {
    func getFinalState(_ nums: [Int], _ k: Int, _ multiplier: Int) -> [Int] {
        (0..<k).reduce(into: nums) { nums, _ in
            let minIndex = nums.indices.reduce(0) { nums[$1] < nums[$0] ? $1 : $0 } 
            nums[minIndex] *= multiplier
        }
    }
}