// https://leetcode.com/problems/find-the-kth-largest-integer-in-the-array

class Solution {
    func kthLargestNumber(_ nums: [String], _ k: Int) -> String {
        var inputArray = nums.map { Double($0)! }.sorted { $0 > $1 }
        
        return String(Int(inputArray[k-1]))
    }
}