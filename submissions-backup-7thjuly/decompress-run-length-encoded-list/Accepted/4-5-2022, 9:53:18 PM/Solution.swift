// https://leetcode.com/problems/decompress-run-length-encoded-list

class Solution {
    func decompressRLElist(_ nums: [Int]) -> [Int] {
        var output: [Int] = []
        
        var i = 0
        while i < nums.count {
            let freq = nums[i]
            let val = nums[i+1]
            
            for f in 0..<freq {
                output.append(val)
            }
            
            i += 2
        }
        
        return output
    }
}