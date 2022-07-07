// https://leetcode.com/problems/kth-largest-element-in-an-array

class Solution {
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var inputArray = nums.sorted { $0 > $1 }
        
        return inputArray[k-1]
    }
}